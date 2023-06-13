require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it "response status should be correct" do
      get users_url
      expect(response).to have_http_status(:ok)
    end
    it "renders users/index template" do
      get users_url
      expect(response).to render_template(:index)
    end
    it "response body should be 'Here are list of users with number of posts.'" do
      get users_url
      expect(response.body).to include("Here are list of users with number of posts.")
    end
  end
  describe 'GET/show' do
    before(:all) do
      @user = User.create(name: 'John Doe', photo: 'https://example.com/user.jpg', bio: 'Lorem ipsum dolor sit amet.', posts_counter: 0)
    end
    it "renders successful response" do
      get user_url(@user)
      expect(response).to be_successful
    end
    it "renders users/show template" do
      get user_url(@user)
      expect(response).to render_template(:show)
    end
    it "response body should be 'Here is list of posts with bio for each user.'" do
      get user_url(@user)
      expect(response.body).to include("Here is list of posts with bio for each user.")
    end
  end

end
