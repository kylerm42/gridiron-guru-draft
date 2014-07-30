class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    if !session[:token].nil? && (current_session = Session.find_by_token(session[:token]))
      @current_user = User.find(current_session.user)
    end
  end

  def logged_in?
    !!current_user
  end

  def sign_in(user)
    token = SecureRandom.urlsafe_base64
    session[:token] = token
    Session.create!(token: token, user: user)
  end

  def sign_out
    @session = Session.find_by_token(session[:token])
    session[:token] = nil

    @session.destroy if @session
  end

  def set_flash(type, message)
    flash[type.to_sym] ||= []
    message.is_a?(String) ? flash[type.to_sym] << message : flash[type.to_sym] += message
  end

  def set_flash_now(type, message)
    flash.now[type.to_sym] ||= []
    message.is_a?(String) ? flash.now[type.to_sym] << message : flash.now[type.to_sym] += message
  end

  FA_FLASH_ICONS = {
    error: 'exclamation-circle',
    success: 'check-circle-o',
    info: 'info-circle',
    warning: 'question-circle'
  }
end
