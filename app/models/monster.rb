class Monster < ActiveRecord::Base
  attr_accessible :custom_name, :experience, :level, :user_id, :species_id, :user_name

  belongs_to :user
  belongs_to :species

  validates :level, numericality: true
  validates :experience, numericality: true

end
