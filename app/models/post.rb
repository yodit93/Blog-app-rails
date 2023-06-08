class Post < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: :author_id

    def user_posts_counter
        posts_counter = author.posts_counter || 0
        author.update(posts_counter: posts_counter + 1)
    end
end
