module SessionsHelpers
  def sign_in
    User.all.delete_all
    user_attributes = FactoryGirl.attributes_for(:user)
    user = FactoryGirl.create(:user, user_attributes)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_attributes[:password]
    click_button 'Sign in'
  end
end
