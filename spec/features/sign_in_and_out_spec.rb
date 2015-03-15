require 'spec_helper'

feature 'user logs in to the 4 networks' do             # no point in testing OmniAuth

  scenario 'user signs in into Facebook' do
    visit '/'
    click_link ('#signout_facebook') if logged_in?(:facebook)
    expect(page).to have_content('Sign in to post on Facebook')
    mock_auth_hash
    click_link ('Sign in to post on Facebook')
    expect(page).to have_content('Logged into Facebook as:')
    expect(page).to have_content('mockuser')
    expect(logged_in?(:facebook)).to be_truthy
  end
 
  # it "can handle authentication error" do
  #   OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  #   visit '/'
  #   page.should have_content("Sign in with Twitter")
  #   click_link "Sign in"
  #   page.should have_content('Authentication failed.')
  # end

end