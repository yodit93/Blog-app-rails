class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  validate :title, presence: true, length: { maximum: 250 }
  validate :comments_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validate :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def user_posts_counter
    posts_counter = author.posts_counter || 0
    author.update(posts_counter: posts_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
