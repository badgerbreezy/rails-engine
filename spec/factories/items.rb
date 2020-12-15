FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Commerce.department }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
