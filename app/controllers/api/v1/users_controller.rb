module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user, only: %i[current update]
      before_action :set_user, only: %i[update]
      load_and_authorize_resource except: %i[create]

      def create
        ActiveRecord::Base.transaction do
          begin
            user = User.new(user_params)
            if user.save
              Api::V1::CreateAccountService.new(user.id).call.save
              render json: user, status: :created
            else
              render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
          rescue StandardError => e
            render json: { errors: "Houve um erro na criação do usuário." }, status: 500
            raise ActiveRecord::Rollback
          end
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def current
        render json: current_user
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end