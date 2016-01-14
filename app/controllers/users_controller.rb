class UsersController < ApplicationController
  before_action :require_user, only: [:follow, :unfollow, :timeline]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Register Successfully!!"
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  def follow
    leader = User.find(params[:id])
    if leader
      current_user.following_users << leader
      flash[:notice] = "You have followed #{leader.username}!!"
      redirect_to user_path(leader.username)
    else
      wrong_path
    end
  end

  def unfollow
    user = User.find(params[:id])
    if user
      relationship = current_user.following_relationships.find_by(follower_id: current_user.id, leader_id: user.id)
      relationship.destroy
      flash[:notice] ="You are no longer follow #{user.username}"
      redirect_to :root
    else
      wrong_path
    end
  end

  def timeline
    @statuses = [ ]
    current_user.following_users.each do |user|
      @statuses << user.statuses
    end
    @statuses.flatten!   ##todo : sort by created time
  end

  def mentions
    current_user.mentions.each do |mention|
      mention.update(viewed_at: DateTime.now)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end