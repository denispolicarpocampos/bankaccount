require 'rails_helper'

RSpec.describe User, type: :model do
  context "create user" do
    subject { FactoryBot.create(:user) }
      
    it "is not valid without name" do
      should validate_presence_of(:name)
    end
  
    it "is not valid without email" do
      should validate_presence_of(:email)
    end

    it "is not valid if email is not unique" do
      should validate_uniqueness_of(:email)
    end
  
  end
end
