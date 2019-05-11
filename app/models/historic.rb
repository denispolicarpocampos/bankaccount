class Historic < ApplicationRecord
  belongs_to :account, :class_name => "Account", :foreign_key => :source_id, :primary_key => "number"
  belongs_to :account, :class_name => "Account", :foreign_key => :destination_id, :primary_key => "number"

  validates_presence_of :amount

end
