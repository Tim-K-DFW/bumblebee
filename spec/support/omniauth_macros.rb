module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new( {
      'provider' => 'facebook',
      'uid' => '123545',
      'user_info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url',
        'urls' => { 'Facebook' => 'www.fake.com' }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end
end