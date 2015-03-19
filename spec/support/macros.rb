def logged_in?(provider)
  page.has_content?("Logged into #{provider == :linkedin ? 'LinkedIn' : provider.to_s.humanize}")
end

def set_up_capybara_external
  OmniAuth.config.test_mode = false
  Capybara.current_driver = :mechanize
  @agent ||= Mechanize.new.tap do |agent|
    agent.set_proxy("localhost", 3000)
  end
end

def set_up_capybara_internal
  OmniAuth.config.test_mode = true
  Capybara.current_driver = :rack_test
end

def fabricate_poster_instance
  post = { body: Faker::Lorem.word }
  Poster::POST_METHODS.keys.each { |provider| post[provider.to_s] = ["0","1"].sample
}
  logins = fabricate_logins
  p = Poster.new(post, logins)
end

def fabricate_logins
  result = {}
  Poster::POST_METHODS.keys.each do |provider|
    coin_flip = (0..1).to_a.sample
    result[provider] = 'fake_uid' if coin_flip == 1
  end
  result
end

def set_up_posting_mock
  post = fabricate_poster_instance
  Poster::POST_METHODS.keys.each do |provider|
    eval("allow(post).to receive(:post_to_#{provider}) do |arg|
      'posted to #{provider}!'
    end")
  end
  post
end
