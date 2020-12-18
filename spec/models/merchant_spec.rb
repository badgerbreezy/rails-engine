require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe '#methods' do
    before :each do
      @invoice_1 = create(:invoice, :with_invoice_items)
      @invoice_2 = create(:invoice, :with_invoice_items)
      @invoice_3 = create(:invoice, :with_invoice_items)
      @invoice_4 = create(:invoice, :with_invoice_items)
      @invoice_5 = create(:invoice, :with_invoice_items)
      Invoice.all.each do |object|
        object.transactions.create(result: 'success', credit_card_number: '1234123412341234')
      end
      @merchant_1 = @invoice_1.merchant
      @merchant_2 = @invoice_2.merchant
      @merchant_3 = @invoice_3.merchant
      @merchant_4 = @invoice_4.merchant
      @merchant_5 = @invoice_5.merchant
    end

    it '.most_revenue' do
      limit_three = Merchant.most_revenue(3)

      expect(limit_three.first.revenue).to be > limit_three.last.revenue
    end

    it '.merchant_revenue' do
      sum_1 = @invoice_1.invoice_items.sum do |item|
        item.unit_price
      end.round(2)
      sum_2 = @invoice_2.invoice_items.sum do |item|
        item.unit_price
      end.round(2)
      expect(Merchant.merchant_revenue(@merchant_1.id).revenue.round(2)).to eq(sum_1)
      expect(Merchant.merchant_revenue(@merchant_2.id).revenue.round(2)).to eq(sum_2)

      merchant_result_1 = Merchant.merchant_revenue(@merchant_1.id)
      expect(merchant_result_1.name).to_not eq(@merchant_2.name)
    end

    it '.merchant_revenue' do
      create_list(:item, 10, merchant_id: @merchant_1.id)
      create_list(:item, 8, merchant_id: @merchant_2.id)
      create_list(:item, 6, merchant_id: @merchant_3.id)
      create_list(:item, 4, merchant_id: @merchant_4.id)
      create_list(:item, 2, merchant_id: @merchant_5.id)

      expect(Merchant.most_items(4).length).to eq(4)
      expect(Merchant.most_items(4).first.items.length).to be > Merchant.most_items(4).last.items.length
      expect(Merchant.most_items(4).first.items.length).to be > @merchant_5.items.length
    end
  end
end
