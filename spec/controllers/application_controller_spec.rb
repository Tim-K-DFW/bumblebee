require 'spec_helper'

describe ApplicationController do
  before do
    session[:twitter] = 'test'
    session[:facebook] = nil
  end
  let!(:joe_twitter) { Fabricate(:identity, provider: 'twitter', uid: 'test') }
  let!(:pete_facebook) { Fabricate(:identity, provider: 'facebook', uid: 'test') }

  describe '#logged_in?' do
    it 'returns false when user not logged in' do
      expect(subject.logged_in?(:facebook)).to be_falsey
    end

    it 'returns true when user logged in' do
      expect(subject.logged_in?(:twitter)).to be_truthy
    end
  end

  describe '#current_identity' do
    it 'returns nil when user not logged in' do
      expect(subject.current_identity(:facebook)).to be_nil
    end

    it 'returns a correct Identity object when user logged in' do
      expect(subject.current_identity(:twitter)).to eq(joe_twitter)
    end
  end
end
