require 'spec_helper'

feature 'user posts when signed in' do
  scenario 'on Facebook' do
    OmniAuth.config.test_mode = false
    Capybara.current_driver = :mechanize
    @agent ||= Mechanize.new.tap do |agent|
      agent.set_proxy("localhost", 3000)
    end

    visit 'http://wwww.facebook.com'
    page.fill_in 'email', with: 'syndicate10022@Gmail.com'
    page.fill_in 'pass', with: '987987ppp'
    click_button 'Log In'
    visit '/'
    click_link ('Sign in to post on Facebook')
    fill_in 'post_body', with: Faker::Lorem.word
    check 'post_facebook'
    click_button 'Post'
    expect(page).to have_content('Facebook: Success!')
    click_link('signout_facebook')

    OmniAuth.config.test_mode = true
    Capybara.current_driver = :rack_test
  end
end