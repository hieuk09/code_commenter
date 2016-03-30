class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    warden.set_user(user)
    redirect_to :root
  end

  def destroy
    warden.logout
    flash[:notice] = "You've been logged out"
    redirect_to :root
  end
end
