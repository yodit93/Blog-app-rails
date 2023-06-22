class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(author: @user, post: @post, text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created successfully.'
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
