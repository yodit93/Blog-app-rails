require 'rails_helper'
RSpec.describe 'posts index', type: :system do
  describe 'The content of index page' do
    it 'shows the usernames' do
      User.all.each do |user|
        visit user_posts_path(user)
        expect(page).to have_content(user.name)
      end
    end
    it 'Shows the profile picture' do
      User.all.each do |user|
        visit user_posts_path(user)
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'Shows the number of posts each user has written.' do
      User.all.each do |user|
        visit user_posts_path(user)
        expect(page).to have_content(user.posts_counter)
      end
    end
    it 'Shows the users bio' do
      User.all.each do |user|
        visit user_posts_path(user)
        expect(page).to have_content(user.bio)
      end
    end
    it 'Shows the posts title' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_content("Post # #{post.id}")
        end
      end
    end
    it 'Shows the posts body' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_content(post.body)
        end
      end
    end
    it 'Shows the first comment on a post' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_content(post.comments.first.text)
        end
      end
    end
    it 'Shows the number of comments on a post' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_content(post.comments_counter)
        end
      end
    end
    it 'Shows the number of likes on a post' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_content(post.likes_counter)
        end
      end
    end
    it 'Shows a section for pagination if there are more posts than fit on the view' do
      User.all.each do |user|
        visit user_posts_path(user)
        expect(page).to have_css('.pagination')
      end
    end
  end
  describe 'The links on the show page' do
    it 'Should redirect to the posts show page' do
      User.all.each do |user|
        visit user_posts_path(user)
        user.posts.each do |post|
          expect(page).to have_link("Post # #{post.id}", href: user_post_path(user, post))
        end
      end
    end
  end
end
