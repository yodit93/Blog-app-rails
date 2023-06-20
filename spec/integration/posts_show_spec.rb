require 'rails_helper'

RSpec.describe 'posts show', type: :system do
  describe 'The content of show page' do
    it 'shows the posts title' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          expect(page).to have_content("Post # #{post.id}")
        end
      end
    end
    it 'Shows the author of the post' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          expect(page).to have_content(post.author.name)
        end
      end
    end
    it 'Shows the number of comments for each post' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          expect(page).to have_content(post.comments_counter)
        end
      end
    end
    it 'Shows the number of likes' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          expect(page).to have_content(post.likes_counter)
        end
      end
    end
    it 'Shows the name of the commenter' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          post.comments.each do |comment|
            expect(page).to have_content(comment.author.name)
          end
        end
      end
    end
    it 'Shows the text of the comment' do
      User.all.each do |user|
        user.posts.each do |post|
          visit user_post_path(user, post)
          post.comments.each do |comment|
            expect(page).to have_content(comment.text)
          end
        end
      end
    end
  end
end
