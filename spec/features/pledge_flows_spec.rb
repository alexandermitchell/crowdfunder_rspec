require 'spec_helper'

describe "Pledge Listing" do
  describe "when visiting the pledge page" do
    before(:each) do
      @project = FactoryGirl.create :project
    end

    it "should require an authenticated user" do
      visit project_path(@project)

      click_link 'Back This Project'

      expect(current_path).to eq(new_session_path)

      expect(page).to have_content("Please login first")
    end

    it "should let an authenticated user pledge a valid amount" do
      user = setup_signed_in_user

      visit project_path(@project)
      click_link 'Back This Project'

      # Should be at pledge submission page, with 0 pledges in the databse currently
      expect(current_path).to eq(new_project_pledge_path(@project))
      expect(Pledge.count).to eq(0)

      fill_in 'pledge[amount]', with: 100
      click_button 'Pledge Now'

      # Should be redirected back to project path with thank you message
      expect(current_path).to eq(project_path(@project))

      expect(page).to have_content("Thanks for pledging")

      # Verify that the pledge was created sith the right attributes
      pledge = Pledge.order(:id).last

      expect(pledge.user).to eq(user)

      expect(pledge.project).to eq(@project)

      expect(pledge.amount).to eq(100)

      expect(last_email).to eq([@project.user.email])
    end
  end
end