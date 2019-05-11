class Account < ApplicationRecord
  belongs_to :user
  has_many :historics, :class_name => "Historic", :foreign_key => "source_id", :primary_key => "number"
  has_many :historics, :class_name => "Historic", :foreign_key => "destination_id", :primary_key => "number"

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number
end
