class BattleController < ApplicationController
  def start
    @skip_header = 'yes'
    render '/index'
  end



end