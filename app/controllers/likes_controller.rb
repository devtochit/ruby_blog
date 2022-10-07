class LikesController < ApplicationController
  def create
    post_id = params[:post_id]
    like = Like.new(author: current_user, post_id:)
    redirect_to user_post_path(current_user, post_id) if like.save
  end
end
