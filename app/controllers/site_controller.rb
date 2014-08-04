class SiteController < ApplicationController

  def root
    if logged_in?
      redirect_to launchpad_path
    else
      render :root
    end
  end

end
