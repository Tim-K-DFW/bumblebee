class Identity < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      identity.oauth_token = auth.credentials.token
      identity.oauth_secret = auth.credentials.secret
      identity.user_id = User.first.blank? ? User.create.id : User.first.id
      identity.refresh_token = auth.credentials.refresh_token
      identity.instance_url = auth.credentials.instance_url
      class_eval("identity.get_profile_data_from_#{identity.provider}(auth)")
      identity.save!
    end
  end

  def get_profile_data_from_facebook(auth)
    self.screen_name = auth.info.name
    self.image_url = auth.info.image
    self.url = auth.info.urls.Facebook
  end

  def get_profile_data_from_twitter(auth)
    self.screen_name = auth.info.nickname
    self.url = auth.info.urls.Twitter
    self.image_url = auth.info.image
  end

  def get_profile_data_from_salesforce(auth)
    self.screen_name = auth.info.name
    self.url = auth.info.urls.profile
    self.image_url = auth.info.image
  end

  def get_profile_data_from_linkedin(auth)
    self.screen_name = auth.info.name
    self.url = auth.info.urls.public_profile
    self.image_url = auth.info.image
  end

  def get_profile_data_from_google_oauth2(auth)
    self.screen_name = auth.info.name
    self.url = auth.info.urls.Google
    self.image_url = auth.info.image
  end

  def set_up_twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = oauth_token
      config.access_token_secret = oauth_secret
    end
    client
  end

  def set_up_salesforce_client
    client = Databasedotcom::Client.new :client_id => ENV["SALESFORCE_KEY"],
      :client_secret => ENV["SALESFORCE_SECRET"]
    client.authenticate :token => oauth_token,
      :instance_url => instance_url,
      :refresh_token => refresh_token
    client.version = "23.0"
    user = Databasedotcom::Chatter::User.find(client, "me")
  end

  def set_up_facebook_client
    client = Koala::Facebook::API.new(oauth_token)
  end

  def set_up_linkedin_client
    client = LinkedIn::Client.new(ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"])
    client.authorize_from_access(oauth_token, oauth_secret)
    client
  end

  def set_up_google_plus_client     # not in use, since Google APIs don't allow posting
    client = Google::APIClient.new

    # client.authorization.client_id = ENV["GOOGLE_PLUS_KEY"]
    # client.authorization.client_secret = ENV["GOOGLE_PLUS_SECRET"]
    # client.authorization.scope = ['plus.login', 'userinfo.profile']

    client.authorization.access_token = oauth_token
    plus = client.discovered_api('plus')

    result = client.execute(
      :api_method => plus.activities.list,
      :parameters => {'collection' => 'public', 'userId' => 'me'} )

    client
  end

end 