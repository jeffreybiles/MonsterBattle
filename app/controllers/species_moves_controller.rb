class SpeciesMovesController < ApplicationController
  # GET /species_moves
  # GET /species_moves.json
  def index
    @species_moves = SpeciesMove.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @species_moves }
    end
  end

  # GET /species_moves/1
  # GET /species_moves/1.json
  def show
    @species_move = SpeciesMove.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @species_move }
    end
  end

  # GET /species_moves/new
  # GET /species_moves/new.json
  def new
    @species_move = SpeciesMove.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @species_move }
    end
  end

  # GET /species_moves/1/edit
  def edit
    @species_move = SpeciesMove.find(params[:id])
  end

  # POST /species_moves
  # POST /species_moves.json
  def create
    @species_move = SpeciesMove.new(params[:species_move])

    respond_to do |format|
      if @species_move.save
        format.html { redirect_to @species_move, notice: 'Species move was successfully created.' }
        format.json { render json: @species_move, status: :created, location: @species_move }
      else
        format.html { render action: "new" }
        format.json { render json: @species_move.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /species_moves/1
  # PUT /species_moves/1.json
  def update
    @species_move = SpeciesMove.find(params[:id])

    respond_to do |format|
      if @species_move.update_attributes(params[:species_move])
        format.html { redirect_to @species_move, notice: 'Species move was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @species_move.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /species_moves/1
  # DELETE /species_moves/1.json
  def destroy
    @species_move = SpeciesMove.find(params[:id])
    @species_move.destroy

    respond_to do |format|
      format.html { redirect_to species_moves_url }
      format.json { head :no_content }
    end
  end
end
