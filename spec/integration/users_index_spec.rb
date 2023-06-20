require 'rails_helper'

RSpec.describe 'users index', type: :system do
  describe 'The content of index page' do
    it 'shows the usernames' do
      visit root_path
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'Shows the profile picture' do
      visit root_path
      User.all.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'Shows the number of posts each user has written.' do
      visit root_path
      User.all.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end
  describe 'The links on the index page' do
    it 'Should redirect to the users show page' do
      visit root_path
      User.all.each do |user|
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end
  end
end