module Api
  module V1
    class AccountSerializer < ActiveModel::Serializer # >
      attributes :number
    end
  end
end