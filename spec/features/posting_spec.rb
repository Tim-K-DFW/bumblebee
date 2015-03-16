require 'spec_helper'

feature 'user tries to publish a post without authentication' do
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
end