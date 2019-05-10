module Api
  module V1
    class CreateAccountService
      def initialize user
        @user = user
      end

      def call
        Account.new(number: generate_token, user_id: @user)
      end

      private

      def generate_token
        token = loop do
          random_token = Random.rand (1..99999)
          break random_token unless Account.exists?(number: random_token)
        end
      end
    end
  end
end