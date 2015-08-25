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

    context 'tasks by status' do
      before do
        user.tasks.clear
        user.tasks << FactoryGirl.create_list(:active_task, 2)
        user.tasks << FactoryGirl.create_list(:completed_task, 3)
      end

      it 'fetches only active tasks' do
        get :index, token: user.token, format: :json, status: 'active'
        expect(JSON.parse(response.body)).to have(2).items
      end

      it 'fetches only completed tasks' do
        get :index, token: user.token, format: :json, status: 'completed'
        expect(JSON.parse(response.body)).to have(3).items
      end

      it 'fetches all tasks' do
        get :index, token: user.token, format: :json
        expect(JSON.parse(response.body)).to have(5).items
      end
    end
  end

end
