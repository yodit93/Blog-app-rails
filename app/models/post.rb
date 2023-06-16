class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :user_posts_counter
  
  def user_posts_counter
    posts_counter = author.posts_counter || 0
    author.update(posts_counter: posts_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
