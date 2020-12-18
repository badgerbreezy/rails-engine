class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  def self.revenue_across_dates(start, ending)
    start_date = start.to_date.beginning_of_day
    end_date = ending.to_date.end_of_day
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .where(invoices: { status: 'shipped' })
      .where(invoices: { created_at: start_date..end_date })[0]
  end
end
