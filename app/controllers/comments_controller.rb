class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(author: current_user, post: @post, text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_path(params[:user_id], @post), notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    post_comments_counter = @post.comments_counter
    @post.update(comments_counter: post_comments_counter - 1)
    redirect_to user_post_path(@post.author, @post), notice: 'Comment deleted successfully.'
  end
end
