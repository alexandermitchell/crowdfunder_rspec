class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :projects
  attr_accessible :first_name, :last_name, :email, :password
end
