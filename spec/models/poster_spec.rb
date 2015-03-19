require 'spec_helper'

describe Poster do
  
  let!(:twitter_identity) { Fabricate(:identity, provider: 'twitter') }
  let!(:facebook_identity) { Fabricate(:identity, provider: 'facebook') }
  let!(:linkedin_identity) { Fabricate(:identity, provider: 'linkedin') }
  let!(:salesforce_identity) { Fabricate(:identity, provider: 'salesforce') }
  let!(:post) { set_up_posting_mock }

  describe '#batch_publish' do
    it 'fills status hash for all providers that the user selected' do
      post.batch_publish
      expect(post.status.keys).to eq(post.providers)
    end

    # scenario 'when not logged in into a network' do
    #   it 'generates error for respective provider'
    #   it 'does not call poster method for respective provider'
    # end

    # scenario 'when logged in into a network' do
    #   it 'calls correct poster method for respective provider'
    #   it 'generates success message if posting was successful'
    #   it 'generates error message if posting failed'
    # end
  end # '#batch_publish'


  describe '#post_to_provider'
  describe '#get_providers'
  describe '#set_up_twitter_client'
  describe '#set_up_facebook_client'
  describe '#set_up_linkedin_client'
  describe '#set_up_salesforce_client'
  
end
