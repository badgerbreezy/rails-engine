require 'rails_helper'

describe "Merchants API" do
  before :each do
    create_list(:merchant, 3, :with_items)
    @merchant_1 = Merchant.first
    @merchant_2 = Merchant.last
  end

  it "can search for a single merchant" do
    merchant_params = ({
      name: Merchant.first.name,
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/merchants/find?name=#{merchant_params[:name]}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data][:attributes][:name]).to eq(@merchant_1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(@merchant_2.name)
  end

  it "can search for multiple merchants" do
    merchant_1 = Merchant.create(
      name: "Gold Diggers Jewelry Inc."
    )
    merchant_2 = Merchant.create(
      name: "Silver Foxes Jewelry Inc."
    )
    merchant_3 = Merchant.create(
      name: "Diamonds R 4ever"
    )
    merchant_4 = Merchant.create(
      name: "Jared"
    )
    merchant_params = ({
      name: "jeweLr",
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/merchants/find_all?name=#{merchant_params[:name]}"
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchants[:data].count).to eq(2)
    expect(merchants[:data][0][:attributes][:name]).to eq(merchant_1.name)
    expect(merchants[:data][1][:attributes][:name]).to eq(merchant_2.name)
  end

  it "can search merchants by creation date" do
    merchant_params = ({
      created_at: @merchant_1.created_at
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/merchants/find_all?created_at=#{merchant_params[:created_at]}"
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0][:attributes][:name]).to eq(@merchant_1.name)
  end

  it "can search merchants by date updated" do
    merchant_params = ({
      updated_at: @merchant_1.updated_at
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/merchants/find_all?updated_at=#{merchant_params[:updated_at]}"
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0][:attributes][:name]).to eq(@merchant_1.name)
  end

  it "can find a single merchant by creation date " do
    merchant_params = ({
      created_at: @merchant_1.created_at
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/merchants/find?created_at=#{merchant_params[:created_at]}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data][:attributes][:name]).to eq(@merchant_1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(@merchant_2.name)
  end
end
