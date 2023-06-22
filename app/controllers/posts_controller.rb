class PostsController < ApplicationController
  load_and_authorize_resource

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
    @user = current_user
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post created successfully.'
    else
      # Handle validation errors
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    puts 'destroying post'
    @post.comments.destroy_all
    @post.destroy
    user_posts_counter = current_user.posts_counter
    current_user.update(posts_counter: user_posts_counter - 1)
    redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
