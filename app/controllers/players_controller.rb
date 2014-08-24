class PlayersController < ApplicationController
  def index
    @players = Player.all.order('rank')

    render json: @players.as_json
  end
end
