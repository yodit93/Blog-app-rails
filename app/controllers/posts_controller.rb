class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    redirect_to user_posts_path(@user)
  end

  private def post_params
    params.require(:post).permit(:title, :body)
  end
end
