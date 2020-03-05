class SessionsController < ApplicationController
  layout "internal/application"

  def new
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

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end