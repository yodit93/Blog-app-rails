class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes, dependent: :destroy
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :user_posts_counter
  after_destroy :user_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def user_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
