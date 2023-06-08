require 'rails_helper'
describe Like do
  describe '#post_likes_counter' do
    it 'should update the post likes_counter' do
      user = User.create(name: 'name', posts_counter: 0)
      post = Post.create(title: 'title', text: 'text', author: user, comments_counter: 0, likes_counter: 0)
      like = Like.create(author: user, post:)
      like.post_likes_counter
      expect(post.likes_counter).to eq(1)
    end
  end
end
