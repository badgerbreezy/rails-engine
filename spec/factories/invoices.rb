FactoryBot.define do
  factory :invoice do
    status { 'shipped'}
    customer
    merchant

    trait :with_invoice_items do
      after :create do |invoice|
        create_list(:invoice_item, 4, invoice: invoice)
      end
    end
  end
end
