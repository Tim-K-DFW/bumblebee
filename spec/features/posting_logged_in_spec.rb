require 'spec_helper'

feature 'user posts when signed in' do
  before { mock_poster_class }

  scenario 'on Facebook' do
    mock_auth_hash
    visit '/'
    click_link('Sign in to post on Facebook')
    fill_in 'post_body', with: Faker::Lorem.word
    check 'post_facebook'
    click_button 'Post'
    expect(page).to have_content('Facebook: Success!')
  end

  scenario 'on Twitter' do
    mock_auth_hash
    visit '/'
    click_link('Sign in to post on Twitter')
    fill_in 'post_body', with: Faker::Lorem.word
    check 'post_twitter'
    click_button 'Post'
    expect(page).to have_content('Twitter: Success!')
  end

  scenario 'on LinkedIn' do
    mock_auth_hash
    visit '/'
    click_link('Sign in to post on LinkedIn')
    fill_in 'post_body', with: Faker::Lorem.word
    check 'post_linkedin'
    click_button 'Post'
    expect(page).to have_content('LinkedIn: Success!')
  end

  scenario 'on Salesforce' do
    mock_auth_hash
    visit '/'
    click_link('Sign in to post on Salesforce')
    fill_in 'post_body', with: Faker::Lorem.word
    check 'post_salesforce'
    click_button 'Post'
    expect(page).to have_content('Salesforce: Success!')
  end
end
