require 'spec_helper'

describe "UserMailer" do
  it "new pledge" do
    project = FactoryGirl.create :project
    pledge = FactoryGirl.create :pledge, project: project
    backer = pledge.user
    email = UserMailer.new_pledge(pledge).deliver

    expect(email.to).to eq([project.user.email])

    expect(email.subject).to eq("Your project received some backing on CrowdFunder.")
  end
end