require 'swagger_helper'
require 'json-schema'

RSpec.describe 'Blog API', type: :request do
  path '/api/v1/users' do
    get 'Fetches all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   photo: {type: :string},
                   bio: {type: :string},
                   posts_counter: {type: :string},
                   created_at: { type: :string, format: 'date' },
                   updated_at: { type: :string, format: 'date' },
                   email: { type: :string },
                   role: {type: :string}
                 },
                 required: ['id', 'name', 'email']
               }

        run_test! do
          # Fetches all users
          get '/api/v1/users'
          expect(response).to have_http_status(:ok)
          expect(response).to match_json_schema('users/index')
        end
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Fetches a user by ID' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'OK' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          photo: {type: :string},
          bio: {type: :string},
          posts_counter: {type: :string},
          created_at: { type: :string, format: 'date' },
          updated_at: { type: :string, format: 'date' },
          email: { type: :string },
          role: {type: :string}
        },
        required: ['id', 'name', 'email']

        run_test! do
          # Fetches a user by ID
          user = User.first
          get "/api/v1/users/#{user.id}"
          expect(response).to have_http_status(:ok)
          expect(response).to match_json_schema('users/show')
        end
      end
    end
  end

  path 'api/v1/users/{user_id}/posts' do
    parameter name: :user_id, in: :path, type: :integer, required: true

    get 'Fetches all posts of a user' do
      tags 'Posts'
      produces 'application/json'
      description 'Fetches all posts of a user.'

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                  id: { type: :integer },
                  title: { type: :string },
                  text: { type: :string },
                  author_id: { type: :integer },
                  comments_counter: { type: :integer },
                  likes_counter: { type: :integer },
                  created_at: { type: :string, format: 'date' },
                  updated_at: { type: :string, format: 'date' }
                 },
                 required: ['id', 'title', 'text', 'author_id']
               }

        run_test! do
          # Fetches all posts of a user
          user = User.first
          get "api/v1/users/#{user.id}/posts"
          expect(response).to have_http_status(:ok)
          expect(response).to match_json_schema('posts/index')
        end
      end
    end
  end

  path 'api/v1/users/{user_id}/posts/{id}' do
    parameter name: :user_id, in: :path, type: :integer, required: true, description: 'User ID'
    parameter name: :id, in: :path, type: :integer, required: true, description: 'Post ID'

    get 'Fetches a post by ID' do
      tags 'Posts'
      produces 'application/json'
      description 'Fetches a post by its ID.'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                id: { type: :integer },
                title: { type: :string },
                text: { type: :string },
                author_id: { type: :integer },
                comments_counter: { type: :integer },
                likes_counter: { type: :integer },
                created_at: { type: :string, format: 'date' },
                updated_at: { type: :string, format: 'date' }
               },
               required: ['id', 'title', 'text', 'user_id']

        run_test! do
          # Fetches a post by ID
          user = User.first
          post = Post.first
          get "api/v1/users/#{user.id}posts/#{post.id}"
          expect(response).to have_http_status(:ok)
          expect(response).to match_json_schema('posts/show')
        end
      end
    end
  end
  
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: :user_id, in: :path, type: :integer, required: true
    parameter name: :post_id, in: :path, type: :integer, required: true

    get 'Fetches all comments of a post' do
      tags 'Comments'
      produces 'application/json'
      description 'Fetches all comments of a post.'

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   user_id: { type: :integer },
                   post_id: { type: :integer }
                 },
                 required: ['id', 'text', 'user_id', 'post_id']
               }

        run_test! do
          # Fetch all comments of a post
          user = User.first
          post = Post.create(title: 'Sample Post', text: 'Sample Text', author: user)
          Comment.create(text: 'Sample Comment 1', user_id: 1, post_id: post.id)
          Comment.create(text: 'Sample Comment 2', user_id: 2, post_id: post.id)

          get "/api/v1/users/#{user.id}/posts/#{post.id}/comments"
          expect(response).to have_http_status(:ok)
        end
      end
    end

    post 'Creates a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          user_id: { type: :integer },
          post_id: { type: :integer }
        },
        required: ['text', 'user_id', 'post_id']
      }

      response '201', 'Created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string },
                 user_id: { type: :integer },
                 post_id: { type: :integer }
               },
               required: ['id', 'text', 'user_id', 'post_id']

        run_test! do
          # Create a comment for a post
          post = Post.create(title: 'Sample Post', text: 'Sample Text', author: User.first)
          comment_params = { text: 'Sample Comment', user_id: 1, post_id: post.id }

          post "/api/v1/users/#{post.author_id}/posts/#{post.id}/comments", params: { comment: comment_params }
          expect(response).to have_http_status(:created)
        end
      end
    end
  end
end
