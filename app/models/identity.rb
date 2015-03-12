class Identity < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      identity.oauth_token = auth.credentials.token
      identity.oauth_secret = auth.credentials.secret
      identity.user_id = User.first.blank? ? User.create.id : User.first.id
      eval("identity.get_profile_data_from_#{identity.provider}")
      identity.save!
    end
  end

  def get_profile_data_from_facebook
    client = Koala::Facebook::API.new(oauth_token)
    user_info = client.get_object("me?fields=name,link,picture")
    self.screen_name = user_info["name"]
    self.image_url = user_info["picture"]["data"]["url"]
    self.url = user_info["link"]
  end

  def get_profile_data_from_twitter
    client = set_up_twitter_client
    self.screen_name = client.user.screen_name
    self.url = client.user.url.to_s
    self.image_url = client.user.profile_image_url.to_s.gsub('normal', 'mini')
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

  def set_up_facebook_client
    client = Koala::Facebook::API.new(oauth_token)
  end

end