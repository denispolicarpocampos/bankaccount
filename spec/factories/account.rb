FactoryBot.define do
  factory :account do
    number         { rand(1..99999) }
    amount          { FFaker.numerify("#.##") }
    user
  end
end