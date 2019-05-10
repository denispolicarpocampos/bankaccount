class User < ApplicationRecord
  has_secure_password
  has_one :account

  validates_length_of :password,
                      maximum: 72,
                      minimum: 8,
                      allow_nil: false,
                      allow_blank: false

  validates_presence_of :name, :email
  validates_uniqueness_of :email
end
