class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :num_items do |object|
    object.items.count
  end
end
