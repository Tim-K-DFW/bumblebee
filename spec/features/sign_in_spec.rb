require 'spec_helper'

feature 'user logs in to the 4 networks' do

  background { mock_auth_hash }

  scenario 'user signs in into Facebook' do
    visit '/'
    click_link ('signout_facebook') if logged_in?(:facebook)
    expect(page).to have_content('Sign in to post on Facebook')
    click_link ('Sign in to post on Facebook')
    expect(page).to have_content('Logged into Facebook as:')
    expect(page).to have_content('mockuser')
    expect(logged_in?(:facebook)).to be_truthy
  end

  scenario 'user signs in into Twitter' do
    visit '/'
    click_link ('signout_twitter') if logged_in?(:twitter)
    expect(page).to have_content('Sign in to post on Twitter')
    click_link ('Sign in to post on Twitter')
    expect(page).to have_content('Logged into Twitter as:')
    expect(page).to have_content('mockuser')
    expect(logged_in?(:twitter)).to be_truthy
  end

  scenario 'user signs in into Salesforce' do
    visit '/'
    click_link ('signout_salesforce') if logged_in?(:salesforce)
    expect(page).to have_content('Sign in to post on Salesforce')
    click_link ('Sign in to post on Salesforce')
    expect(page).to have_content('Logged into Salesforce as:')
    expect(page).to have_content('mockuser')
    expect(logged_in?(:salesforce)).to be_truthy
  end

  scenario 'user signs in into LinkedIn' do
    visit '/'
    click_link ('signout_linkedin') if logged_in?(:linkedin)
    expect(page).to have_content('Sign in to post on LinkedIn')
    click_link ('Sign in to post on LinkedIn')
    expect(page).to have_content('Logged into LinkedIn as:')
    expect(page).to have_content('mockuser')
    expect(logged_in?(:linkedin)).to be_truthy
  end
 
  scenario 'user fails to sign in into Facebook with invalid credentials' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit '/'
    click_link ('signout_facebook') if logged_in?(:facebook)
    expect(page).to have_content('Sign in to post on Facebook')
    click_link ('Sign in to post on Facebook')
    expect(logged_in?(:facebook)).to be_falsey 
  end

  scenario 'user fails to sign in into Twitter with invalid credentials' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    visit '/'
    click_link ('signout_twitter') if logged_in?(:twitter)
    expect(page).to have_content('Sign in to post on Twitter')
    click_link ('Sign in to post on Twitter')
    expect(logged_in?(:twitter)).to be_falsey 
  end

  scenario 'user fails to sign in into Salesforce with invalid credentials' do
    OmniAuth.config.mock_auth[:salesforce] = :invalid_credentials
    visit '/'
    click_link ('signout_salesforce') if logged_in?(:salesforce)
    expect(page).to have_content('Sign in to post on Salesforce')
    click_link ('Sign in to post on Salesforce')
    expect(logged_in?(:salesforce)).to be_falsey 
  end

  scenario 'user fails to sign in into LinkedIn with invalid credentials' do
    OmniAuth.config.mock_auth[:linkedin] = :invalid_credentials
    visit '/'
    click_link ('signout_linkedin') if logged_in?(:linkedin)
    expect(page).to have_content('Sign in to post on LinkedIn')
    click_link ('Sign in to post on LinkedIn')
    expect(logged_in?(:linkedin)).to be_falsey 
  end
end