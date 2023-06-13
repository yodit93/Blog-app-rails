require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:all) do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/user.jpg', bio: 'Lorem ipsum dolor sit amet.', posts_counter: 0)
    @post = Post.create(title:'title', text:'text', author:@user, comments_counter:0, likes_counter:0)
  end
  describe 'GET /users/:user_id/posts' do
    it "return successful response" do
      get user_posts_path(@user)
      expect(response).to have_http_status(:ok)
    end
    it "renders posts/index template" do
      get user_posts_path(@user)
      expect(response).to render_template(:index)
    end
    it "response body should be 'Here is list of posts and corresponding comments for each user.'" do
      get user_posts_path(@user)
      expect(response.body).to include("Here is list of posts and corresponding comments for each user.")
    end
  end
  describe 'GET/show' do
    it "renders successful response" do
      get user_post_path(@user, @post)
      expect(response).to be_successful
    end
    it "renders posts/show template" do
      get user_post_path(@user, @post)
      expect(response).to render_template(:show)
    end
    it "response body should be 'Here is the content of each post with comments.'" do
      get user_post_path(@user, @post)
      expect(response.body).to include("Here is the content of each post with comments.")
    end
  end
end
