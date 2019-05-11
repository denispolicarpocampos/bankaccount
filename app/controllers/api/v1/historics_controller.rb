module Api
  module V1
    class HistoricsController < Api::V1::ApiController
      before_action :authenticate_user

      def create
        source = Account.find_by(number: historic_params[:source_account_id])

        return render json: "You do not have sufficient credit", status: :unprocessable_entity if source.amount < historic_params[:amount].to_d

        return render json: "You is not a owner of account!", status: :forbidden if source.user_id != current_user.id

        AddTransferJob.perform_later(historic_params[:source_account_id], historic_params[:destination_account_id], historic_params[:amount])
        render json: "Transfer under evaluation", status: :created
      end

      private

      def historic_params
        params.require(:historic).permit(:source_account_id, :destination_account_id, :amount)
      end

    end
  end
end