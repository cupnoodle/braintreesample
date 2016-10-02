class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview
  #omniauth only, no normal signup/login
  def new_session_path(scope)
    new_user_session_path
  end

end
