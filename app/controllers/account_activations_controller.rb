class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user.present? and not user.activated? and user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Activated user."
      redirect_to user
    else
      flash[:danger] = "Invalid activation link."
      redirect_to root_url
    end
  end
end
