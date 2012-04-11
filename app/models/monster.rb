class Monster < ActiveRecord::Base
  attr_accessible :custom_name, :experience, :level

  belongs_to :user
  belongs_to :species

  validates :level, numericality: true
  validates :experience, numericality: true
end
