require 'spec_helper'

describe "User Authentication" do
  describe "when visiting the sign in page" do
    it "should successfully register a user" do
      
      visit "/users/new"
      expect(current_path).to eq(new_user_path)

      within(:css, '.navbar') do
        find_link("Sign Up").visible?
      end

      user = FactoryGirl.build(:user)

      # Fill in the form with the info from user created by FactoryGirl
      fill_in "user[email]", :with => user.email
      fill_in "user[first_name]", :with => user.first_name
      fill_in "user[last_name]", :with => user.last_name
      fill_in "user[password]", :with => user.password
      click_button "Create Account"

      # After submitting the form, should be redirected to root
      expect(current_path).to eq(root_path)
      # While a message says "Account Created"
      expect(page).to have_content("Account Created")
      # And the nav no longer has a link to Sign Up but Logout
      within(:css, '.navbar') do
        has_no_link?('Sign Up')
        has_link?('Logout')
      end
    end
    it "should fail registration" do
      visit "/users/new"
      user = FactoryGirl.build(:user)

      #Invalid form submission
      fill_in "user[email]", :with => user.email
      click_button "Create Account"

      # Should redirect to users_path and ...
      expect(current_path).to eq(users_path)
      # ... no message saying "account created" should appear

      expect(page).to have_no_content("Account Created")

      within(:css, ".alert") do
        have_content("Try again")
      end
    end
    it "should successfully log in" do
      visit '/'
      find('.navbar').has_no_link?('Logout').should be_true
      # Calling the helper method here and it returns a user
      user = setup_signed_in_user
      find('.navbar').has_link?('Logout').should be_true
    end
    it "should unsuccessfully log in" do
      visit '/session/new'

      fill_in "email", with: "a@b.com"
      fill_in "password", with: "invalid creds"
      click_button "Login"

      expect(current_path).to eq(session_path)

      expect(page).to have_content('Invalid')
    end
    it "should successfully logout" do
      user = setup_signed_in_user

      visit '/'

      find('.navbar').click_link 'Logout'

      expect(page).to have_content("Bye")

      find('.navbar').has_no_link?('Logout')
    end
  end
end
