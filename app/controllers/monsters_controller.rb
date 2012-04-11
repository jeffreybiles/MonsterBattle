class MonstersController < ApplicationController
  make_resourceful do
    actions :new, :edit, :update, :show, :index, :destroy
  end

  def create
    @monster = Monster.new(params[:monster])
    @monster.set_stats
    respond_to do |format|
      if @monster.save
        format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
        format.json { render json: @monster, status: :created, location: @monster }
      else
        format.html { render action: "new" }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

end
