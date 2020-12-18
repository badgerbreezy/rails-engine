class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  def self.most_revenue(limit)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order("revenue desc")
      .limit(limit)
  end

  def self.merchant_revenue(id)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .where(id: id)
    .group(:id)
    .first
  end

  def self.most_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order("revenue desc")
      .limit(quantity)
  end

  def self.revenue_across_dates(start, ending)
    start_date = start.to_date.beginning_of_day
    end_date = ending.to_date.end_of_day
    Invoice.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .where(invoices: { created_at: start_date..end_date })[0]
  end
end
