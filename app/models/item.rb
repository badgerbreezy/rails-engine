class Item < ApplicationRecord

  validates :name, :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
end
