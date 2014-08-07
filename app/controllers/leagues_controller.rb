class LeaguesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @league = League.new

    render :new
  end

  def create
    @league = current_user.managed_leagues.build(permitted_params)



    if params[:league][:password] == params[:league][:password_confirm] && @league.save
      set_flash(:success, "You have successfully created a league")

      redirect_to launchpad_path
    else
      set_flash_now(:error,
                (@league.errors.empty? ? "Password fields must match" : @league.errors.full_messages))

      render :new, status: 422
    end
  end

  def edit
    @league = League.find(params[:id])

    render :edit
  end

  def update
    @league = League.find(params[:id])

    if @league.update_attributes(permitted_params)
      set_flash(:success, 'League successfully updated!')

      redirect_to launchpad_path
    else
      set_flash_now(:error, @league.errors.full_messages)

      render :edit, status: 422
    end
  end

  def invite
    @league = League.find_by_activation_key(params[:activation_key])

    if @league && @league.full?
      set_flash(:warning, 'That league is already full')
      redirect_to launchpad_path
    else
      render :invite
    end
  end

  def join
    @league = League.find_by_activation_key(params[:league][:activation_key])

    if @league && @league.can_join?(params[:password])
      @team = @league.teams.where(owner: nil).order(:draft_slot).first
      @team.update_attributes(owner: current_user)

      redirect_to launchpad_path
    else
      set_flash_now(:error, @league ? @league.errors.full_messages : 'League not found')

      render :invite
    end
  end

  private

    def permitted_params
      params.require(:league).permit(:name, :tagline, :password, :team, positions:
        League::POSITION_NAMES).reject { |key, value| value.blank? }
    end
end
