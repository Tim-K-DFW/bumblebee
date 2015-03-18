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