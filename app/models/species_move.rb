class SpeciesMove < ActiveRecord::Base
  attr_accessible :level_learned, :move_id, :species_id

  belongs_to :species
  belongs_to :move
end
