class DraftPicksController < ApplicationController
  def index
    @league = League.find(params[:id])
    @draft_picks = @league.draft_picks

    render json: @draft_picks.as_json
  end
end
