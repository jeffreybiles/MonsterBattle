class SpeciesController < ApplicationController
  def index
    @species = Species.all
  end

  def show
    @species = Species.find(params[:id])
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.new(params[:species])
    if @species.save
      redirect_to @species, :notice => "Successfully created species."
    else
      render :action => 'new'
    end
  end

  def edit
    @species = Species.find(params[:id])
  end

  def update
    @species = Species.find(params[:id])
    if @species.update_attributes(params[:species])
      redirect_to @species, :notice  => "Successfully updated species."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @species = Species.find(params[:id])
    @species.destroy
    redirect_to species_url, :notice => "Successfully destroyed species."
  end
end
