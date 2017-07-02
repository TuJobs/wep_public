class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      "1" == params[:session][:remember_me] ? remember(user) : forget(user)
      remember user
      redirect_back_or user
    else
      flash.now[:danger] = t ".warning"
      render :new
    end
  end

  def destroy
    flash[:success] = t ".logout_user"
    log_out if logged_in?
    redirect_to root_url
  end
end
