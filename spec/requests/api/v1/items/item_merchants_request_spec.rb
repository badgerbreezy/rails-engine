require 'rails_helper'

describe "Item Merchant API" do
  it "can find the merchant that carries the item" do
    id = create(:item).id

    get "/api/v1/items/#{id}/merchants"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(item_merchant[:data]).to have_key(:id)
    expect(item_merchant[:data][:id]).to be_a(String)

    expect(item_merchant[:data][:attributes]).to have_key(:name)
    expect(item_merchant[:data][:attributes][:name]).to be_a(String)
  end
end
