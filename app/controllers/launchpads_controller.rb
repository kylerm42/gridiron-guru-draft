class LaunchpadsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    render :show
  end
end
