class SpeciesController < ApplicationController
  make_resourceful do
    actions :new, :edit, :create, :show, :update, :destroy
  end

  def index
    @species = Species.all
  end

end
