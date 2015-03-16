require 'spec_helper'

feature 'user publishes a post' do
  context 'without authentication' do
    background do
      visit '/'
      fill_in 'post_body', with: 'random post'
    end

    scenario 'on Facebook' do
      check 'post_facebook'
      click_button 'Post'
      expect(page).to have_content('You cannot post on Facebook until you log in.')
    end

    scenario 'on Twitter' do
      check 'post_twitter'
      click_button 'Post'
      expect(page).to have_content('You cannot post on Twitter until you log in.')
    end

    scenario 'on LinkedIn' do
      check 'post_linkedin'
      click_button 'Post'
      expect(page).to have_content('You cannot post on LinkedIn until you log in.')
    end

    scenario 'on Salesforce' do
      check 'post_salesforce'
      click_button 'Post'
      expect(page).to have_content('You cannot post on Salesforce until you log in.')
    end
  end # context 'without authentication'

  context 'with authentication' do
    scenario 'on Facebook' do
      
      Capybara.app_host = "http://localhost:3000/"
      # mech = Mechanize.new
      # current_page = mech.get('http://facebook.com')
      # login_form = current_page.form
      # email_field = login_form.field_with(name: "email")
      # password_field = login_form.field_with(name: "pass")
      # email_field.value = 'syndicate10022@gmail.com'
      # password_field.value = "987987ppp"

      Capybara.app_host = "https://arcane-earth-9950.herokuapp.com/"
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
      binding.pry

      click_link ('Sign in to post on Facebook')

    end

  end
end