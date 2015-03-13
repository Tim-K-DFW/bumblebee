class Poster
  attr_accessor :body, :providers, :author, :status, :logins

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
        status[provider] = "You cannot post on #{provider.to_s.humanize} until you log in. To log in, just click the link above."
      end
    end
  end

  private

  def get_providers(args)
    result = []
    result << 'twitter'.to_sym if args[:to_twitter] == '1'
    result << 'facebook'.to_sym if args[:to_facebook] == '1'
    result << 'salesforce'.to_sym if args[:to_salesforce] == '1'
    result
  end

  def post_to_facebook(post)
    client = author.set_up_facebook_client
    begin
      outcome = 'Success. Check out the post (coming soon).' if client.put_connections("me", "feed", :message => post)
    rescue
      outcome = 'Error while posting: (coming soon)'
    end
    outcome
  end

  def post_to_twitter(post)
    client = author.set_up_twitter_client
    begin
      outcome = 'Success. Check out the post (coming soon).' if client.update(post)
    rescue
      outcome = 'Error while posting: (coming soon)'
    end
    outcome
  end

  def post_to_salesforce(post)
    client = author.set_up_salesforce_client
    begin
      outcome = 'Success. Check out the post (coming soon).' if client.post_status(post)
    rescue
      outcome = 'Error while posting. If this is your first time posting to this user, make sure that country and stare picklists are disabled (Setup/Data Management in Salesforce).'
    end
    outcome
  end

end