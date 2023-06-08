class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :author, class_name: 'User', foreign_key: :author_id

    def post_comments_counter
        comments_counter = post.comments_counter || 0
        post.update(comments_counter: comments_counter + 1)
    end
end
