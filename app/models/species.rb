class Species < ActiveRecord::Base
  attr_accessible :name, :hp_growth, :attack_growth, :defense_growth

  validates :name,
            presence: true,
            uniqueness: true
  validates :hp_growth, numericality: true
  validates :attack_growth, numericality: true
  validates :defense_growth, numericality: true

  has_many :monsters
end
