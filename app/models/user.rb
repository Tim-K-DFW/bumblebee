class User < ActiveRecord::Base
  attr_reader :screen_name, :image_url, :url

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  def tweet(tweet)
    client = set_up_twitter_client
    client.update(tweet)
  end

  def get_profile_data_from_provider
    client = set_up_twitter_client
    binding.pry
    @screen_name = client.user.screen_name
    @url = client.user.url.to_s
    @image_url = client.user.profile_image_url.to_s.gsub('normal', 'mini')
  end

  private

  def set_up_twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = oauth_token
      config.access_token_secret = oauth_secret
    end
    client
  end

end
