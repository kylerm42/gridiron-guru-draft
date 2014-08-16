class UsersController < ApplicationController
  before_action :already_signed_in?, only: [:new, :create]
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(permitted_params)

    if params[:user][:password] == params[:user][:password_confirm] && @user.save
      sign_in(@user)
      set_flash(:success, "You have successfully created an account!")

      redirect_to session[:redirect_to] || root_path
    else
      set_flash_now(:error,
                (@user.errors.empty? ? "Password fields must match" : @user.errors.full_messages))

      render :new, status: 422
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:username, :email, :first_name,
                                   :last_name, :password)
    end

    def already_signed_in?
      if logged_in?
        set_flash(:error, "You already have an account. You can't do that!")
        redirect_to session[:redirect_to] || root_path
      end
    end
end
