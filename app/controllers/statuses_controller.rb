class StatusesController < ApplicationController
  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    user = User.first
    @status.creator = user  ##Update after Authentiction
    if @status.save
      flash[:notice] = "Successfully Create a Status!!"
      redirect_to user_path(user.username)
    else 
      render 'new'
    end
        
  end



  private

  def status_params
    params.require(:status).permit(:body)
  end
end