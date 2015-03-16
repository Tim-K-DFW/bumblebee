require 'spec_helper'

feature 'user logs out of the 4 networks' do

  background { mock_auth_hash }

  scenario 'user signs out of Facebook' do
    visit '/'
    click_link ('Sign in to post on Facebook') unless logged_in?(:facebook)
    click_link ('signout_facebook')
    expect(logged_in?(:facebook)).to be_falsey
  end

  scenario 'user signs out of Twitter' do
    visit '/'
    click_link ('Sign in to post on Twitter') unless logged_in?(:twitter)
    click_link ('signout_twitter')
    expect(logged_in?(:twitter)).to be_falsey
  end

  scenario 'user signs out of Salesforce' do
    visit '/'
    click_link ('Sign in to post on Salesforce') unless logged_in?(:salesforce)
    click_link ('signout_salesforce')
    expect(logged_in?(:salesforce)).to be_falsey
  end

  scenario 'user signs out of LinkedIn' do
    visit '/'
    click_link ('Sign in to post on LinkedIn') unless logged_in?(:linkedin)
    click_link ('signout_linkedin')
    expect(logged_in?(:linkedin)).to be_falsey
  end
end