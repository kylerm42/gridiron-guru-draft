class LeaguesController < ApplicationController
  def new
    @league = League.new

    render :new
  end

  def create
    @league = League.new(permitted_params)
    @league.number_of_teams = 10
    @league.manager = current_user

    if params[:league][:password] == params[:league][:password_confirm] && @league.save
      set_flash(:success, "You have successfully created a league")

      redirect_to league_url(@league)
    else
      set_flash(:error,
                (@league.errors ? @league.errors.full_messages : "Password fields must match"))

      render :new
    end
  end

  def show
    @league = League.find(params[:id])

    render :show
  end

  private

    def permitted_params
      params.require(:league).permit(:name, :password)
    end
end
