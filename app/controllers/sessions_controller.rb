# frozen_string_literal: true

class SessionsController < ApplicationController
  layout "internal/application"

  def new
    redirect_home_if_logged
  end

  def create
    user = User.find_by email: session_params[:email].downcase

    if user && user.authenticate(session_params[:password])
      log_in user
      remember user
      redirect_back_or_home
    else
      flash[:error] = "Usuário/senha inválidos"
      redirect_to login_path
    end
  end

  def destroy
    log_out if Current.user.present?
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
