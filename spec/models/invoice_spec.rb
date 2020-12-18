require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
  end

  describe "#methods" do
    it '.revenue_across_dates' do
      create_list(:customer, 2)
      customer_1 = Customer.all.first
      customer_2 = Customer.all.last
      invoice_1 = create(:invoice, :with_invoice_items)
      invoice_2 = create(:invoice, :with_invoice_items)
      invoice_3 = create(:invoice, :with_invoice_items)
      invoice_4 = create(:invoice, :with_invoice_items)
      invoice_5 = create(:invoice, :with_invoice_items)

      Invoice.all.each do |object|
        object.transactions.create(result: 'success', credit_card_number: '1234123412341234')
      end

      invoice_1.update(
        created_at: "2012-03-09"
      )
      invoice_2.update(
        created_at: "2012-03-22"
      )
      invoice_3.update(
        created_at: "2012-03-24"
      )
      invoices_dates = []
      invoices_dates << invoice_1
      invoices_dates << invoice_2
      invoices_dates << invoice_3
      invoice_items = invoices_dates.map do |invoice|
        invoice.invoice_items
      end.flatten
      sum = invoice_items.sum do |invoice_item|
        invoice_item.unit_price
      end
      start = '2012-03-09'
      ending = '2012-03-24'

      expect(Invoice.revenue_across_dates(start, ending).round(2)).to eq(sum)
    end
  end
end
