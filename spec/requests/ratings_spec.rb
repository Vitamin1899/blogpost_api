require 'rails_helper'

RSpec.describe 'Ratings API', type: :request do
  let(:user) { create(:user) }
  let(:posts) { create_list(:post, 10, user: user) }
  let(:post_id) { posts.first.id }

  describe 'POST /ratings' do
    let(:valid_attributes) do
      {
        post_id: post_id,
        value: 5
      }
    end

    context 'when the request is valid' do
      before { post '/ratings', params: valid_attributes }

      it 'creates a rating' do
        expect(json).to be_between(0 ,5)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/ratings', params: { value: 4 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
