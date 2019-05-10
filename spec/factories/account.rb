FactoryBot.define do
  factory :account do
    number         { rand(1..99999) }
    user
  end
end