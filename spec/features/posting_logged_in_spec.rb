require 'spec_helper'

feature 'user posts when signed in' do

  scenario 'on Facebook' do
    mock_auth_hash
    VCR.use_cassette 'user_posts_when_signed_in/on_facebook', match_requests_on: [:method, :host, :path] do
      visit '/'
      click_link ('Sign in to post on Facebook')
      fill_in 'post_body', with: Faker::Lorem.word
      check 'post_facebook'
      click_button 'Post'
      expect(page).to have_content('Facebook: Success!')
    end
  end

end