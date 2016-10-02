class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview

  # when there is only omniauth, no normal signup/login
  def new_session_path(scope)
    new_user_session_path
  end

  # path to redirect user after sign in
  def after_sign_in_path_for(resource)
    user_index_path
  end

  # Require user login
  def require_login
    if !user_signed_in?
      #redirect_to user_login_path
      redirect_to root_path
    end
  end

end
