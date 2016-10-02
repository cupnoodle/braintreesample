class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    #@user = User.from_omniauth(request.env["omniauth.auth"])
    #
    #if @user.persisted?
    #  sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    #  set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #else
    #  session["devise.facebook_data"] = request.env["omniauth.auth"]
    #  redirect_to new_user_registration_url
    #end
    puts "le oauth info"
    puts  request.env["omniauth.auth"]

    provider = request.env["omniauth.auth"]["provider"]
    uid = request.env["omniauth.auth"]["uid"]
    access_token = request.env["omniauth.auth"]["credentials"]["token"]
    username = request.env["omniauth.auth"]["info"]["nickname"]

    puts "provider is #{provider}"
    puts "uid is #{uid}"
    puts "access token is #{access_token}"
    puts "username is #{username}"

    @user = User.where(:uid => uid).take

    if !@user
        @user = User.create(:oauth_token => access_token, :uid => uid, :provider => provider, :username => username)
    else
        @user.oauth_token = access_token
        @user.save
    end

    sign_in_and_redirect @user, :event => :authentication
    flash[:success] = "Login success"
    #set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?

    #redirect_to root_path
  end

  def failure
    flash[:danger] = "Twitter login error"
    redirect_to root_path
  end

end