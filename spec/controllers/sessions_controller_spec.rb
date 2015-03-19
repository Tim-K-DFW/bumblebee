require 'spec_helper'

describe SessionsController do
  describe 'GET add' do
    let!(:identity) { Fabricate(:identity, provider: 'twitter', uid: 'fake_uid') }
    before { allow(Identity).to receive(:from_omniauth).and_return(Identity.first) }

    it 'adds uid of new identity to session hash' do
      get :add, provider: 'twitter'
      expect(session[identity.provider]).to eq(identity.uid)
    end

    it 'redirects to root path' do
      get :add, provider: 'twitter'
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET destroy' do
    it 'clears session hash for respective provider' do
      session[:twitter] = 'fake_uid'
      get :destroy, provider: 'twitter'
      expect(session[:twitter]).to be_nil
    end

    it 'redirects to root path' do
      get :destroy, provider: 'twitter'
      expect(response).to redirect_to(root_path)
    end
  end
end
