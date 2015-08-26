require 'spec_helper'
require 'top_tal_api'

describe 'Session', type: :feature do
  include Capybara::Angular::DSL

  context 'sign_in, sign_out' do
    let(:user_attributes) { FactoryGirl.attributes_for(:user) }
    let!(:user) { FactoryGirl.create(:user, user_attributes) }
    
    it 'sign in' do
      visit root_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user_attributes[:password]
      click_button 'Sign in'

      page.should have_content('Sign Out')
    end

    it 'sign out' do
      sign_in

      all(:link, 'Sign Out')[0].click

      page.should have_content('Sign in')
    end
  end
end
