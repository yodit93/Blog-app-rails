require 'rails_helper'
describe User do
  before(:all) do
    @user = User.create(name: 'name', posts_counter: 0)
    @post = Post.create(title: 'title', text: 'text', author: @user, comments_counter: 0, likes_counter: 0)
  end

  it 'should name be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'should posts_counter be present' do
    @user.posts_counter = nil
    expect(@user).to_not be_valid
  end

  it 'should posts_counter be integer' do
    @user.posts_counter = 'string'
    expect(@user).to_not be_valid
  end

  it 'should posts_counter be greater than or equal to 0' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  describe '#recent_posts' do
    it 'should return 3 posts' do
      5.times do
        Post.create(title: 'title', text: 'text', author: @user, comments_counter: 0, likes_counter: 0)
      end
      expect(@user.recent_posts.count).to eq(3)
    end
  end
end
