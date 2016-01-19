class HashtagsController < ApplicationController
  def show
    @statuses = Status.get_status_of_hashtag(params[:id])
  end
end