class Pledge < ActiveRecord::Base
  attr_accessible :amount, :project_id, :user_id

  belongs_to :user
  belongs_to :project

  validates :user_id, :project_id, :amount, presence: true
  validates :amount, numericality: true
end
