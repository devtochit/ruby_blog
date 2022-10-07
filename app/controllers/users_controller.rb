class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @posts = @user.get_most_recent_posts(3)
  end
end
