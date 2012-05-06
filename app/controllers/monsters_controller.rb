class MonstersController < ApplicationController
  make_resourceful do
    actions :new, :create, :edit, :update, :destroy, :index
  end

  def show
    @monster = Monster.find(params[:id])
    @moves = @monster.species.moves
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => {monster: @monster, techniques: @moves}}
    end
  end
end
