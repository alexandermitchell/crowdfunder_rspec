class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :projects
  has_many :pledges
  attr_accessible :first_name, :last_name, :email, :password
  validates :first_name, :last_name, :email, :password, :presence => true 


  def name
    "#{first_name} #{last_name}"
  end
end
