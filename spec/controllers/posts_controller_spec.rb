require 'spec_helper'

describe PostsController do
  describe 'POST create' do
    let! (:params) { { 'post' => { 'body' => 'qwer', 'twitter' => '1', 'facebook' => '1', 'linkedin' => '1', 'salesforce' => '1' } } }
    before do
      fabricate_identities
      mock_poster_class
    end

    it 'creates a Poster object with correct message body' do
      post :create, params
      expect(assigns(:poster).body).to eq('qwer')
    end

    it 'creates a Poster object with correct provider list' do
      post :create, params
      expect(assigns(:poster).providers).to match_array([:facebook, :twitter, :salesforce, :linkedin])
    end

    it 'creates a Poster object with IDs of logged in identities' do
      Poster::POST_METHODS.keys.each { |provider| session[provider] = 'fake_uid' }
      post :create, params
      expect(assigns(:poster).logins).to eq(facebook: 'fake_uid',
                                            twitter: 'fake_uid',
                                            linkedin: 'fake_uid',
                                            salesforce: 'fake_uid')
    end

    it 'calls #batch_publish on Poster instance' do
      expect_any_instance_of(Poster).to receive(:batch_publish)
      post :create, params
    end

    it 'renders Create template and passes post statuses to it' do
      post :create, params
      expect(response).to render_template('create')
    end
  end
end
