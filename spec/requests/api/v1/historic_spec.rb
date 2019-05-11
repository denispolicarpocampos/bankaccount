require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'Api::V1::Historic', type: :request do

  describe 'post /api/v1/transfer' do

    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :post, '/api/v1/transfer'
    end

    context 'Authenticated' do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }
      let!(:account) { create(:account, user: user) }
      let!(:account2) { create(:account, user: user2) }

      context "user is owner of source account" do
      
        context 'when amount is lower than total value' do
          before do
            post "/api/v1/transfer", params: {"historic": {"source_account_id": account.number, "destination_account_id": account2.number, "amount": account.amount / 10}} , headers: header_with_authentication(user)
          end

            it { expect(response).to have_http_status(:success) }
        end

        context 'when user is higher than total value' do

          before do
            post "/api/v1/transfer", params: {"historic": {"source_account_id": account.number, "destination_account_id": account2.number, "amount": account.amount * 2}} , headers: header_with_authentication(user)
          end

            it { expect(response).to have_http_status(:unprocessable_entity) }

        end
      end

      context "user is not owner of source account" do
      
          before do
            post "/api/v1/transfer", params: {"historic": {"source_account_id": account.number, "destination_account_id": account2.number, "amount": account.amount / 10}} , headers: header_with_authentication(user2)
          end

            it { expect(response).to have_http_status(:forbidden) }

      end
    end
  end
end