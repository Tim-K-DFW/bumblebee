#
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

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new( {
      'provider' => 'twitter',
      'uid' => '123545',
      'user_info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url',
        'nickname' => 'mockuser',
        'urls' => { 'Twitter' => 'www.fake.com' }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })

    OmniAuth.config.mock_auth[:salesforce] = OmniAuth::AuthHash.new( {
      'provider' => 'salesforce',
      'uid' => '123545',
      'user_info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url',
        'urls' => { 'profile' => 'www.fake.com' }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })

    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new( {
      'provider' => 'linkedin',
      'uid' => '123545',
      'user_info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url',
        'urls' => { 'public_profile' => 'www.fake.com' }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end
end
