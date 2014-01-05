class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    if @user = login(params[:username], params[:password])
      redirect_back_or_to(posts_path, message: "Login exitoso")
    else
      flash.now[:alert] = "Algo salio mal en el login"
      render action: :new
    end
  end
  def destroy
    logout
    redirect_to(:users, message: "Logged out")
  end
end