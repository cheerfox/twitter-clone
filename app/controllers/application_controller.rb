class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :unread_mention_amount_for_current_user, :generate_links

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You haven't logged in!!"
      redirect_to root_path
    end
  end

  def wrong_path
    flash[:error] = "Something goes wrong!!"
    redirect_to :root
  end

  def unread_mention_amount_for_current_user
    current_user.unread_mention_amount
  end

  def generate_links(status_body)
    status_body = generate_hashtag_links(status_body)
    generate_mentions_links(status_body)
  end

  def generate_hashtag_links(status_body)
    status_body.gsub(/#(\w+)/, "<a href=/hashtags/\\1>#\\1</a>").html_safe
  end

  def generate_mentions_links(status_body)
    status_body.gsub(/@(\w+)/, "<a href=/\\1>@\\1</a>").html_safe
  end

  def extract_statuses_from_mentions
    statuses = []
    current_user.mentions.each do |mention|
      statuses << mention.status
    end
    statuses
  end
end
