require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'Api::V1::Users', type: :request do

  describe 'GET /api/v1/users/current' do
    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :get, '/api/v1/users/current'
    end

    context 'Authenticated' do
      let(:user) { create(:user) }

      before do
        get '/api/v1/users/current', headers: header_with_authentication(user)
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns valid user in json' do
        expect(json).to eql(serialized(Api::V1::UserSerializer, user))
      end
    end
  end

  describe 'POST /api/v1/users' do
    context 'Valid params' do
      let(:user_params) { attributes_for(:user) }

      it 'return created' do
        post '/api/v1/users/', params: { user: user_params }
        expect(response).to have_http_status(:created)
      end

      it 'returns right user in json' do
        post '/api/v1/users/', params: { user: user_params }
        expect(json).to include_json(user_params.except(:password))
      end

      it 'create user' do
        expect do
          post '/api/v1/users/', params: { user: user_params }
        end.to change { User.count }.by(1)
      end
    end

    context 'Invalid params' do
      let(:user_params) { {foo: :bar} }

      before { post '/api/v1/users/', params: { user: user_params } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /api/v1/users/:id' do
    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :put, '/api/v1/users/-1'
    end

    context 'Authenticated' do
      context 'Resource owner' do
        context 'Valid params' do
          let(:user) { create(:user) }
          let(:user_params) { attributes_for(:user) }

          before do
            put "/api/v1/users/#{user.id}", params: { user: user_params }, headers: header_with_authentication(user)            
          end

          it { expect(response).to have_http_status(:success) }

          it 'returns json with user updated' do
            expect(json).to include_json(user_params.except(:password))
          end
        end

        context 'Invalid params' do
          let(:user_params) { {foo: :bar} }

          before { post '/api/v1/users/', params: { user: user_params } }

          it { expect(response).to have_http_status(:unprocessable_entity) }
        end
      end

      context 'Not resource owner' do
        let(:user) { create(:user) }
        let(:other_user) { create(:user) }
        let(:user_params) { attributes_for(:user) }

        before do
          put "/api/v1/users/#{other_user.id}", params: {user: user_params }, headers: header_with_authentication(user)
        end

        it { expect(response).to have_http_status(:forbidden) }
      end
    end
  end
end