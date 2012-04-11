class MonstersController < ApplicationController
  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @monsters }
    end
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
    @monster = Monster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @monster }
    end
  end

  # GET /monsters/new
  # GET /monsters/new.json
  def new
    @monster = Monster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @monster }
    end
  end

  # GET /monsters/1/edit
  def edit
    @monster = Monster.find(params[:id])
  end

  # POST /monsters
  # POST /monsters.json
  def create
    @monster = Monster.new(params[:monster])
    unless @monster.level then @monster.level = 1 end
    unless @monster.experience then @monster.experience = 0 end
    #these next six lines are in desperate need of refactoring.  Use metaprogramming (see examples in rails antipatterns) after tests are in place.
    @monster.max_hp = @monster.level * @monster.species.hp_growth - (rand()*@monster.level/2).round(0)
    @monster.max_attack= @monster.level * @monster.species.attack_growth - (rand()*@monster.level/2).round(0)
    @monster.max_defense= @monster.level * @monster.species.defense_growth - (rand()*@monster.level/2).round(0)
    @monster.current_hp = @monster.max_hp
    @monster.current_attack = @monster.max_attack
    @monster.current_defense = @monster.max_defense
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

  # PUT /monsters/1
  # PUT /monsters/1.json
  def update
    @monster = Monster.find(params[:id])

    respond_to do |format|
      if @monster.update_attributes(params[:monster])
        format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy
    @monster = Monster.find(params[:id])
    @monster.destroy

    respond_to do |format|
      format.html { redirect_to monsters_url }
      format.json { head :no_content }
    end
  end
end
