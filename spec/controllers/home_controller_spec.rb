require 'spec_helper'

describe HomeController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  context 'access' do
    it 'prohibits unauthorized' do
      get :index
      expect(response).to redirect_to '/users/sign_in'
    end

    it 'permits authorized user' do
      authenticate user
      session[:token] = user.token
      get :index
      expect(response).to render_template :index
    end
  end
end
