class Poster
  include ApplicationHelper
  attr_accessor :body, :providers, :author, :status, :logins
  POST_METHODS = { twitter: 'update(post)',
                   facebook: 'put_connections("me", "feed", :message => post)',
                   linkedin: 'add_share(:comment => post)',
                   salesforce: 'post_status(post)' }

  def initialize(post, logins)
    @body = post[:body]
    @providers = get_providers(post)
    @status = {}
    @logins = logins
  end
  
  def batch_publish
    providers.each do |provider|
      if logins[provider]
        @author = Identity.where(provider: provider, uid: logins[provider]).first
        status[provider] = instance_eval("post_to_#{provider}(body)")
      else
        status[provider] = "You cannot post on #{pretty_provider_name(provider)} until you log in. To log in, just click the link above."
      end
    end
  end

  private

  POST_METHODS.keys.each do |provider|
    class_eval %Q(
      def post_to_#{provider}(post)
        client = set_up_#{provider.to_s}_client
        begin
          outcome = 'Success!' if client.#{POST_METHODS[provider]}
        rescue
          outcome = "Error. Try again or try posting directly on #{provider.to_s.humanize} website."
        end
        outcome
      end
    )
  end

  def get_providers(args)
    result = []
    POST_METHODS.keys.each do |provider|
      result << provider if args[provider.to_s] == '1'
    end
    result
  end

  def set_up_twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = author.oauth_token
      config.access_token_secret = author.oauth_secret
    end
    client
  end

  def set_up_salesforce_client
    client = Databasedotcom::Client.new :client_id => ENV["SALESFORCE_KEY"],
      :client_secret => ENV["SALESFORCE_SECRET"]
    client.authenticate :token => author.oauth_token,
      :instance_url => author.instance_url,
      :refresh_token => author.refresh_token
    client.version = "23.0"
    user = Databasedotcom::Chatter::User.find(client, "me")
  end
  
  def set_up_facebook_client
    client = Koala::Facebook::API.new(author.oauth_token)
    client
  end

  def set_up_linkedin_client
    client = LinkedIn::Client.new(ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"])
    client.authorize_from_access(author.oauth_token, author.oauth_secret)
    client
  end
end
