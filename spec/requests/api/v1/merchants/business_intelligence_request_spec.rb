require 'rails_helper'

describe 'Merchants BI API' do
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

  it 'can find merchants with most revenue' do
    limit_three = Merchant.most_revenue(3)

    get '/api/v1/merchants/most_revenue?quantity=3'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
  end

  it 'can find revenue for a single merchant' do
    merchant_revenue =
    get "/api/v1/merchants/#{@merchant_1.id}/revenue"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:revenue]).to eq(Merchant.merchant_revenue(@merchant_1.id).revenue)
    expect(merchant[:data][:attributes][:name]).to_not eq(Merchant.merchant_revenue(@merchant_2.id).revenue)
  end

  it 'can find merchants with most items sold' do
    create_list(:item, 10, merchant_id: @merchant_1.id)
    create_list(:item, 8, merchant_id: @merchant_2.id)
    create_list(:item, 6, merchant_id: @merchant_3.id)
    create_list(:item, 4, merchant_id: @merchant_4.id)
    create_list(:item, 2, merchant_id: @merchant_5.id)
    get "/api/v1/merchants/most_items?quantity=3"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].length).to eq(3)
    expect(merchants[:data].first[:attributes][:num_items]).to be > merchants[:data].last[:attributes][:num_items]
    expect(merchants[:data].first[:attributes][:num_items]).to be > @merchant_5.items.length
  end

  it 'can find revenue across a date range' do
    @invoice_1.update(
      created_at: "2012-03-09"
    )
    @invoice_2.update(
      created_at: "2012-03-22"
    )
    @invoice_3.update(
      created_at: "2012-03-24"
    )
    invoices_dates = []
    invoices_dates << @invoice_1
    invoices_dates << @invoice_2
    invoices_dates << @invoice_3
    invoice_items = invoices_dates.map do |invoice|
      invoice.invoice_items
    end.flatten

    sum = invoice_items.sum do |invoice_item|
      invoice_item.unit_price
    end

    get "/api/v1/revenue?start=2012-03-09&end=2012-03-24"
    expect(response).to be_successful

    revenue = JSON.parse(response.body, symbolize_names: true)
    expect(revenue[:data][:attributes]).to have_key(:revenue)
    expect(revenue[:data][:attributes][:revenue]).to be_a(Float)
    expect(revenue[:data][:attributes][:revenue].round(2)).to eq(sum)
  end
end
