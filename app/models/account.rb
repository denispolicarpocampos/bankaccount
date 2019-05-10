class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number
end
