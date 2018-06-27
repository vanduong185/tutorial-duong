class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.present? and user.authenticate(params[:session][:password])
      # flash[:success] = "Welcome #{user.name}"
      log_in user
      if params[:session][:remember_me] == "1"
        remember user
      else
        forget user
      end
      redirect_to user
    else
      flash[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
