require 'spec_helper'

describe "Images" do
  describe "when editing a project" do

    before(:each) do
      @user = setup_signed_in_user
      @project = FactoryGirl.create :project, user: @user
    end

    it "should successfully upload an image for my project" do
      visit edit_my_project_path(@project)

      expect(page).to have_link('Manage Images')
      click_link 'Manage Images'

      # The project shouldn't have any thumbnails
      expect(page).to have_no_selector('.image')

      path = File.join(Rails.root, 'app', 'assets', 'images', "rails.png")
      attach file("image[file]", path)
      click_button("Upload Image")

      expect(page).to have_selector('.image', count: 1)
    end

    it "should fail to upload an image for my project" do
      visit my_project_images_path(@project)

      path = File.join(Rails.root, 'app', 'assets', 'javascripts', "application.js")
      attach_file("image[file]", path)
      click_button("Upload Image")

      # Expect to see an error message
      expect(page).to have_content('not allowed')

      # Should have 0 images on the page
      expect(page).to have_no_selector('.image')
    end
  end
end