class SessionsController < ApplicationController
  def new
  end

  def destroy
    session[:user_id] = nil
    flash.notice = "Logged out!"
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash.notice = "Logged in successfully!"
        redirect_to root_path
    else
        flash.now.alert = "Wrong email or password :(" if params[:email] || params[:password]
        render :new
    end

  end
end
