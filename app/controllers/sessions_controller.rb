class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    else
      @user = User.new

      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      sign_in(@user)
      set_flash(:success, "Welcome back, #{@user.username}")
      redirect_to root_url
    else
      @user = User.new(username: params[:user][:username])
      set_flash(:error, "Invalid username/password combination")
      redirect_to root_url
    end
  end

  def destroy
    sign_out

    set_flash(:success, "You have been signed out.")

    redirect_to root_url
  end
end
