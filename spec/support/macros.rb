def logged_in?(provider)
  page.has_content?("Logged into #{provider == :linkedin ? 'LinkedIn' : provider.to_s.humanize}")
end

def set_up_capybara_external
  OmniAuth.config.test_mode = false
  Capybara.current_driver = :mechanize
  @agent ||= Mechanize.new.tap do |agent|
    agent.set_proxy('localhost', 3000)
  end
end

def set_up_capybara_internal
  OmniAuth.config.test_mode = true
  Capybara.current_driver = :rack_test
end

def fabricate_identities
  Poster::POST_METHODS.keys.each { |provider| Fabricate(:identity, provider: provider.to_s) }
end

def mock_poster_instance
  mock_poster_class
  fabricate_poster_instance
end

def mock_poster_class
  Poster::POST_METHODS.keys.each do |provider|
    eval("allow_any_instance_of(Poster).to receive(:post_to_#{provider}) do |arg|
      arg.body == 'fake error' ? 'Error. Try again or try posting
      directly on #{provider.to_s.humanize} website.' : 'Success!'
    end")
  end
end

def fabricate_poster_instance
  post = { body: Faker::Lorem.word }
  Poster::POST_METHODS.keys.each { |provider| post[provider.to_s] = ['0', '1'].sample }
  logins = fabricate_logins
  Poster.new(post, logins)
end

def fabricate_logins
  result = {}
  Poster::POST_METHODS.keys.each do |provider|
    coin_flip = (0..1).to_a.sample
    result[provider] = 'fake_uid' if coin_flip == 1
  end
  result
end
