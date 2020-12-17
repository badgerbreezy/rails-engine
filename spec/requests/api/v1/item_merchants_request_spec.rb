require 'rails_helper'

describe "Item Merchant API" do
  it "can send a list of merchants that carry the item" do
    id = create(:item).id

    get "/api/v1/items/#{id}/merchants"

    expect(response).to be_successful

    item_merchants = JSON.parse(response.body, symbolize_names: true)
    expect(item_merchants[:data].count).to eq(1)
    item_merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end
