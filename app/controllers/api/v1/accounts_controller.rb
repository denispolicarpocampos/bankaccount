module Api
  module V1
    class AccountsController < Api::V1::ApiController
      before_action :authenticate_user
      before_action :set_account

      def show
        authorize! :show, @account
        render json: @account
      end

      private

      def set_account
        @account = Account.find_by(number: params[:account_id])
      end
    end
  end
end