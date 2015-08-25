require 'spec_helper'

describe TasksController, type: :controller do

  it 'should not permit unauthorized user' do
    get :index, format: :json
    expect(JSON.parse(response.body)).to eq({'error' => 'access denied'})
  end

  context 'permitted' do
    let(:user) { FactoryGirl.create(:user) }
    let(:task) { FactoryGirl.create(:task) }

    before do
      user.tasks << task
      authenticate user
    end

    it 'should permit logged in user' do
      get :index, token: user.token, format: :json
      expect(response.body).to eq([task].to_json)
    end
  end
end
