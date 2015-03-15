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
      instance_eval("identity.get_profile_data_from_#{identity.provider}(auth)")
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
end 