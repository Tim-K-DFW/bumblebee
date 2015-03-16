Fabricator(:identity) do
  uid {'999'}
  oauth_token {'fake_token'}
  oauth_secret {'fake_secret'}
  refresh_token {'fake refresh_token'}
  instance_url {'http://fake_url.com'}
end
