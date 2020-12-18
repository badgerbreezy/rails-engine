require 'rails_helper'

describe "Merchant Items API" do
  it "can send a list of a merchant's items" do
    merchant_1 = create(:merchant, :with_items)
    merchant_2 = create(:merchant, :with_items)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_items[:data].count).to eq(2)
    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
end
