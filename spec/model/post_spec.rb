require 'rails_helper'
describe Post do
  before(:all) do
    @user = User.create(name: 'name', posts_counter: 0)
    @post = Post.create(title: 'title', text: 'text', author: @user, comments_counter: 0, likes_counter: 0)
  end

  it 'should title be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'should comments_counter be present' do
    @post.comments_counter = nil
    expect(@post).to_not be_valid
  end

  it 'should comments_counter be integer' do
    @post.comments_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'should comments_counter be greater than or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'should likes_counter be present' do
    @post.likes_counter = nil
    expect(@post).to_not be_valid
  end

  it 'should likes_counter be integer' do
    @post.likes_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'should likes_counter be greater than or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  describe '#user_posts_counter' do
    it 'should update the user posts_counter' do
      @post.user_posts_counter
      expect(@user.posts_counter).to eq(1)
    end
  end

  describe '#recent_comments' do
    it 'should return 5 comments' do
      10.times do
        Comment.create(text: 'text', author: @user, post: @post)
      end
      expect(@post.recent_comments.count).to eq(5)
    end
  end
end
