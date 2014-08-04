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

      redirect_to league_url(@league)
    else
      set_flash_now(:error,
                (@league.errors.empty? ? "Password fields must match" : @league.errors.full_messages))

      p @league
      render :new, status: 422
    end
  end

  def edit
    @league = League.find(params[:id])

    render :edit
  end

  def update
    @league = League.find(params[:id])
    p permitted_params

    if @league.update_attributes(permitted_params)
      set_flash(:success, 'League successfully updated!')

      redirect_to launchpad_path
    else
      set_flash_now(:error, @league.errors.full_messages)

      render :edit
    end
  end

  private

    def permitted_params
      params.require(:league).permit(:name, :tagline, positions:
        League::POSITION_NAMES)
    end
end
