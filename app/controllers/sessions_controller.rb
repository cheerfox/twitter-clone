class SessionsController < ApplicationController
  def new
    #login form
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.username)
      #login seccess
    else
      flash.now[:error] = "Something goes wrong with your usename or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out!!'
    redirect_to login_path
  end
end