class Item < ApplicationRecord

  validates :name, :description, presence: true
  validates :unit_price, presence: true, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
