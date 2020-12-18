FactoryBot.define do
  factory :transaction do
    result { 'success' }
    credit_card_number { Faker::Business.credit_card_number }
    invoice
  end
end
