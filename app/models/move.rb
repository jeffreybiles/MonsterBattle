class Move < ActiveRecord::Base
  attr_accessible :damage, :hit_chance, :name

  has_many :species_moves
  has_many :specieses, through: :species_moves
end
