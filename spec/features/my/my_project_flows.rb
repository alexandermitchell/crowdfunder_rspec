require 'spec_helper'

describe "Project Listing" do
  describe "when visiting the index page" do
    it "should list only my projects" do
      me = setup_signed_in_user
      other_user = FactoryGirl.create :user

      3.times { FactoryGirl.create :project, user: me }
      2.times { FactoryGirl.create :project, user: other_user, title: "Other Dude's Project" }

      visit '/my/projects'

      expect(page).to have_selector('div.project', count: 3)

      expect(page).to have_no_content("Other Dude's Project")
    end

    it "should edit my project" do
      me = setup_signed_in_user

      project = FactoryGirl.create :project, user: me, title: "My Project"

      visit edit_my_project_path(project)

      fill_in 'project[title]', with: "It really is my project"

      click_button 'Update Project'

      expect(current_path).to eq(my_projects_path)
      expect(page).to have_content("It really is my project")
    end
    it "should not be able to edit someone else's project" do
      me = setup_signed_in_user

      other_user = FactoryGirl.create :user
      project = FactoryGirl.create :project, user: other_user, title: "Other Dude's Project"

      expect { visit edit_my_project_path(project) }.to raise_error
    end
    it "should make projects public" do
      me = setup_signed_in_user

      visit '/my/projects/new'

      fill_in 'project[title]', with: "Test Project"
      fill_in 'project[teaser]', with: "Test Project Teaser"
      fill_in 'project[description]', with: "Test Project Description"
      fill_in 'project[goal]', with: "12000"

      click_button 'Publish Project'

      expect(current_path).to eq(my_projects_path)
    end
    it "should display navigation" do
      user = setup_signed_in_user

      visit '/'

      page.find('.navbar ul').click_link('My Projects')
      expect(current_path).to eq(my_projects_path)

      # My Projects nav element should be active on the My Projects page
      expect(find('.navbar ul li active a').text).to eq("My Projects")
      expect(page).to have_selector('.navbar ul li.active a', count: 1)

      # The nav element should still be active on the new project page
      click_link 'New Project'
      expect(current_path).to eq(new_my_project_path)
      expect(find('.navbar ul li.active a').text).to eq("My Projects")
    end 
  end
end