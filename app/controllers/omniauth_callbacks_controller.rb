class OmniauthCallbacksController < ApplicationController

  #all information retrieved from Facebook by Omniauth is available as a hash at request.env["omniauth.auth"]
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    flash[:notice] = "Signed in successfully"
    sign_in_and_redirect @user
  end
end
