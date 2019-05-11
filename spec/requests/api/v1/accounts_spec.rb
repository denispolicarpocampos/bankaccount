require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'Api::V1::Account', type: :request do

  describe 'GET /api/v1/account/:number' do

    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :get, '/api/v1/accounts/-1'
    end

    context 'Authenticated' do
      context 'when user is owner of account' do
        let(:user) { create(:user) }
        let!(:account) { create(:account, user: user) }

        before do
          get "/api/v1/accounts/#{account.number}", headers: header_with_authentication(user)
        end

          it { expect(response).to have_http_status(:success) }

          it 'returns valid user in json' do
            expect(json).to eql(serialized(Api::V1::AccountSerializer, account))
          end
      end

      context 'when user is not owner of account' do
        let(:user) { create(:user) }
        let(:user2) { create(:user) }
        let!(:account) { create(:account, user: user2) }

        before do
          get "/api/v1/accounts/#{account.number}", headers: header_with_authentication(user)
        end

        it { expect(response).to have_http_status(:forbidden) }

      end
    end
  end
end