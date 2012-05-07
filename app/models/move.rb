class Move < ActiveRecord::Base
  attr_accessible :power, :hit_chance, :name, :animation

  has_many :species_moves
  has_many :specieses, through: :species_moves
end
