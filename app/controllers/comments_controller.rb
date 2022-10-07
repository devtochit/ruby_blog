class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(post:, author: current_user, text: params[:text])
    redirect_to user_post_path(current_user, post) if @comment.save
  end

  private

  def strong_params
    params.require(:user_post_comments).permit(:post_id, :text)
  end
end
