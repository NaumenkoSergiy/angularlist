require 'spec_helper'

describe SessionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context '#create' do
    context 'api' do
      it 'authenticates user' do
        post :create, format: :json, email: user.email, password: 'password'
        expect(JSON.parse(response.body)['result']).to eq('ok')
        expect(JSON.parse(response.body)['access_token']).to eq(user.token)
      end

      it 'does not authenticate user with invalid credentials' do
        post :create, format: :json, email: 'invalid', password: 'invalid'
        expect(JSON.parse(response.body)).to eq({
                                                'result' => 'error',
                                                'message' => 'Invalid email or password' })
      end
    end

    context 'web access' do
      it 'authenticates user' do
        post :create, email: user.email, password: 'password'
        expect(session[:token]).to eq(user.token)
        expect(response).to redirect_to root_path
      end

      it 'does not authenticate user with invalid credentials' do
        post :create, email: 'invalid', password: 'invalid'
        expect(flash[:alert]).to eq('Invalid email or password')
        expect(response).to render_template :new
      end
    end
  end
end
