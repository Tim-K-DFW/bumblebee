Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"], {:scope => 'publish_actions', :image_size => 'square'}
  provider :salesforce, ENV["SALESFORCE_KEY"], ENV["SALESFORCE_SECRET"]
  provider :linkedin, ENV["LINKEDIN_KEY"], ENV["LINKEDIN_SECRET"], {:scope => 'r_basicprofile w_share rw_nus'}
  provider :google_oauth2, ENV["GOOGLE_PLUS_KEY"], ENV["GOOGLE_PLUS_SECRET"], {:scope => ['plus.login', 'userinfo.profile'], :image_size => 40, :image_aspect_ratio => 'square'}
end