class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @user = User.find(params[:user_id])
    @posts = @user.get_most_recent_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:author).most_recent_ones
  end

  def create
    post = Post.new(author: current_user, title: params[:user_posts][:title], text: params[:user_posts][:text])
    redirect_to user_path(current_user) if post.save
  end

  private

  def strong_params
    params.require(:user_posts).permit(:title, :text)
  end
end
