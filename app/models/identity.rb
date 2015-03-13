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

end