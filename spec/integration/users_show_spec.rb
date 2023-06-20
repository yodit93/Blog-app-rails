require 'rails_helper'

RSpec.describe 'users show', type: :system do
  describe 'The content of show page' do
    it 'shows the usernames' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_content(user.name)
      end
    end
    it 'Shows the profile picture' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'Shows the number of posts each user has written.' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_content(user.posts_counter)
      end
    end
    it 'Shows the users bio' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_content(user.bio)
      end
    end
    it 'Shows the three recent posts' do
      User.all.each do |user|
        visit user_path(user)
        user.posts.last(3).each do |post|
          expect(page).to have_content("Post # #{post.id}")
        end
      end
    end
    it 'Shows a button that lets view all of a users posts' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_button('See all posts')
      end
    end
  end
  describe 'The links on the show page' do
    it 'Should redirect to the posts show page' do
      User.all.each do |user|
        visit user_path(user)
        user.posts.last(3).each do |post|
          expect(page).to have_link("Post # #{post.id}", href: user_post_path(user, post))
        end
      end
    end
    it 'Should redirect to the users posts index page' do
      User.all.each do |user|
        visit user_path(user)
        expect(page).to have_link('See all posts', href: user_posts_path(user))
      end
    end
  end
end
