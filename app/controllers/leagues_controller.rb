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

      render :new, status: 422
    end
  end

  def show
    @league = League.find(params[:id])

    render :show
  end

  private

    def permitted_params
      params.require(:league).permit(:name, :password, :tagline)
    end

    def authenticate_user!
      unless logged_in?
        set_flash(:warning, 'You must be signed in to do that')
        redirect_to new_session_path
      end
    end
end
