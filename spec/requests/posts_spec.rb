require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  describe 'POST /posts' do
    let(:valid_attributes) do
      {
        post: { title: 'Test title', content: 'test content', author_ip: '16.123.143.129' },
        user: { login: 'username' }
      }
    end

    context 'when the request is valid' do
      before { post '/posts', params: valid_attributes }

      it 'creates a post' do
        expect(json['title']).to eq('Test title')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params: { post_title: 'Test title' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /posts' do
    before do
      user = create(:user)
      posts = create_list(:post, 10, user: user)
      posts.each do |post|
        create_list(:rating, 5, post_id: post.id)
      end
    end

    context 'when the request w/o top_n param' do
      before { get '/posts' }

      it 'returns posts' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request with top_n param' do
      before { get '/posts?top_n=5' }

      it 'returns top n posts' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
