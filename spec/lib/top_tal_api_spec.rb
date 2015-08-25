require 'spec_helper'
require 'top_tal_api'

describe TopTalApi do
  context '.find_user_by' do
    let(:user) { FactoryGirl.create(:user) }
    let(:token) { 'test token' }
    let(:access_token) { FactoryGirl.create(:access_token, token: token) }

    before do
      user.access_token = access_token
    end

    it 'finds user with valid token' do
      expect(described_class.find_user_by token).to eq(user)
    end

    it 'returns nil with expired token' do
      access_token.update_attribute(:created_at, Time.now - 3.hours)
      expect(described_class.find_user_by token).to be_nil
    end

    it 'returns nil with invalid token' do
      expect(described_class.find_user_by 'invalid token').to be_nil
    end
  end
end
