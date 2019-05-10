module Api
  module V1
    class UserSerializer < ActiveModel::Serializer # >
      attributes :id, :name, :email
      has_one :account

      def account
        AccountSerializer.new(object.account).attributes
      end

    end
  end
end