require 'spec_helper'

describe PostsController do
  # describe 'POST create' do
  #   let! (:params) { {"post"=>{"body"=>"qwer", "twitter"=>"1", "facebook"=>"1", "linkedin"=>"1", "salesforce"=>"1"}} }
    
  #   before do
  #     seed_session_with_logins
  #     Poster::POST_METHODS.keys.each { |provider| Fabricate(:identity, provider: provider.to_s) }
  #     post :create, params
  #   end

  #   it 'creates a Poster object with correct message body' do
  #     binding.pry
  #     expect(assigns(poster).body).to eq('qwer')
  #   end

  #   # it 'creates a Poster object with correct provider list' do
  #   #   expect(assigns(:poster).providers).to match_array([:facebook, :twitter, :salesforce, :linkedin])
  #   # end

  #   # it 'creates a Poster object with empty status' do
  #   #   expect(assigns(:poster).status).to eq({})
  #   # end

  #   # it 'creates a Poster object with IDs of logged in identities' do
  #   #   expect(assigns(:poster).logins).to eq({:facebook => '999', :twitter => '999', :linkedin => '999', :salesforce => '999'})
  #   # end


  #   it 'calls #batch_publish on the Poster instance'
  #   it 'renders Create template and passes post statuses to it'
  # end
end