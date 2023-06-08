require 'rails_helper'
describe Comment do
   describe "#post_comments_counter" do
         it "should update the post comments_counter" do
            user = User.create(name: "name", posts_counter: 0)
            post = Post.create(title: "title", text: "text", author: user, comments_counter: 0, likes_counter: 0)
            comment = Comment.create(text: "text", author: user, post: post)
            comment.post_comments_counter
            expect(post.comments_counter).to eq(1)
         end
    end
end