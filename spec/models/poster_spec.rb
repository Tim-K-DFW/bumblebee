require 'spec_helper'

describe Poster do
  let!(:twitter_identity) { Fabricate(:identity, provider: 'twitter') }
  let!(:facebook_identity) { Fabricate(:identity, provider: 'facebook') }
  let!(:linkedin_identity) { Fabricate(:identity, provider: 'linkedin') }
  let!(:salesforce_identity) { Fabricate(:identity, provider: 'salesforce') }
  let!(:poster) { mock_poster_instance }

  describe '#batch_publish' do
    it 'fills status hash for all providers that the user selected' do
      poster.batch_publish
      expect(poster.status.keys).to eq(poster.providers)
    end

    context 'when not logged in into a network' do
      before { Poster::POST_METHODS.keys.each { |provider| poster.logins[provider] = nil } }

      it 'generates error for respective provider' do
        poster.batch_publish
        poster.providers.each { |provider| expect(poster.status[provider]).to match(/.*until you log in.*/) }
      end

      it 'does not call poster method for respective provider' do
        poster.providers.each { |provider| eval("expect(poster).to_not receive(:post_to_#{provider})") }
        poster.batch_publish
      end
    end # context 'when not logged in into a network'

    context 'when logged in into a network' do
      before { Poster::POST_METHODS.keys.each { |provider| poster.logins[provider] = 'fake_uid' } }

      it 'calls correct poster method for respective provider' do
        poster.providers.each { |provider| eval("expect(poster).to receive(:post_to_#{provider})") }
        poster.batch_publish
      end

      it 'generates success message if posting was successful' do
        poster.batch_publish
        poster.providers.each { |provider| eval("expect(poster.status[:#{provider}]).to eq('Success!')") }
      end

      it 'generates error message if posting failed' do
        poster.body = 'fake error'
        poster.batch_publish
        poster.providers.each { |provider| eval("expect(poster.status[:#{provider}]).to match(/Error. Try again/)") }
      end

      it 'does not change status of providers which user did not select' do
          poster.batch_publish
          poster.providers.each do |provider|
            expect(poster.status[:provider]).to be_nil unless poster.providers.include?(:provider)
          end
      end
    end # context 'when logged in into a network'
  end # '#batch_publish'

  describe '#post_to_provider'
  describe '#get_providers'
  describe '#set_up_twitter_client'
  describe '#set_up_facebook_client'
  describe '#set_up_linkedin_client'
  describe '#set_up_salesforce_client'
  
end
