class Like < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: :author_id
    belongs_to :post

    def post_likes_counter
        likes_counter = post.likes_counter || 0
        post.update(likes_counter: likes_counter + 1)
    end
end
