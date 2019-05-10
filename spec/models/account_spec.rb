require 'rails_helper'

RSpec.describe Account, type: :model do
  context "create account" do
    subject { FactoryBot.create(:account) }
      
    it "is not valid without number account" do
      should validate_presence_of(:number)
    end
  
    it "is not valid without user" do
      should validate_presence_of(:user_id)
    end

    it "is not valid if number is not unique" do
      should validate_uniqueness_of(:number)
    end
  
  end
end
