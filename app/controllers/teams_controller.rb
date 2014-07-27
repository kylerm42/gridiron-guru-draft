class TeamsController < ApplicationController
  def show
    @league = League.find(params[:league_id])
    @team = @league.teams.where(draft_slot: params[:draft_slot])

    render :show
  end

  private

    def permitted_params
      params.require(:team).permit(:name)
    end
end
