class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }

  belongs_to :item
  belongs_to :invoice
end
