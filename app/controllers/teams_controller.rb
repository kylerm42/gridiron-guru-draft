class TeamsController < ApplicationController
  def edit
    @league = League.find(params[:league_id])
    @team = @league.teams.find_by_draft_slot(params[:draft_slot])

    render :edit
  end

  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(permitted_params)
      set_flash(:success, 'Team successfully updated')

      redirect_to launchpad_path
    else
      set_flash_now(:error, @team.errors.full_messages)

      render :edit
    end
  end

  def remove_owner
    @team = Team.find(params[:id])
    owner = @team.owner

    if @team.update_attributes(owner: nil, name: "Team #{@team.draft_slot}")
      set_flash(:success, "Successfully removed #{owner.full_name} as owner")
      
      redirect_to edit_league_path(@team.league)
    else
      set_flash(:error, @team.errors.full_messages)

      redirect_to edit_league_path(@team.league)
    end
  end

  private

    def permitted_params
      params.require(:team).permit(:name, :color)
    end
end
