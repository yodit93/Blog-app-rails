class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.create(author: @user, post: @post)
    redirect_to user_post_path(id: @post.id)
  end
end
