module LoginHelper
  def login_user!
    @user = Factory(:user)
    visit '/users/sign_in'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  end
end

