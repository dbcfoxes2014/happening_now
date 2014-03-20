require 'spec_helper'

feature "User" do
  context 'on home page' do
    xit "can see the title of the site" do
      visit root_path
      expect(page).to have_content "RecomMemeDo"
    end

    it "should be able to go to signup form" do
      visit new_user_registration_path
      expect(page).to have_content "Sign up"
    end
  end

  context "sign_up page and sign_in" do
    xit "should be able to sign up to use a service" do
      visit new_user_registration_path
      expect {
        fill_in 'user_first_name' , :with => "test"
        fill_in 'user_last_name', :with => "user"
        fill_in 'user_email', :with => "email@email.com"
        fill_in 'user_password', :with => "testtest"
        fill_in 'user_password_confirmation', :with => "testtest"
        click_button "Sign up"
      }.to change(User, :count).by(1)
      expect(page).to have_content "Welcome! You have signed up successfully."
    end

    it "should get errors if field is left empty" do
      visit new_user_registration_path
        fill_in 'user_last_name', :with => "user"
        fill_in 'user_email', :with => "email@email.com"
        fill_in 'user_password', :with => "testtest"
        fill_in 'user_password_confirmation', :with => "testtest"
        click_button "Sign up"
        expect(page).to have_content "prohibited this user from being saved"
    end

    xit "should return an error if account is invalid on sign in" do
      visit new_user_session_path
      fill_in 'user_email', :with => "emaiasdfasdfasdfl@email.com"
      fill_in 'user_password', :with => "jhfgfuijoldkvijnbs"
      click_button "Sign in"
      expect(page).to have_content "Invalid email or password."
    end
  end

  context "user profile page" do
    it "should show a users name" do
    @user = User.create(:first_name => "Name", :last_name => "Last", :email => "jbwilmoth@joe.com", :password => "password1", :password_confirmation => "password1" )
      visit user_path(@user.id)
      expect(page).to have_content "Name Last"
    end
  end
end