require 'rails_helper'

describe "Items API" do
  before :each do
    create_list(:item, 2)
    @item_params = ({
      unit_price: Item.first.unit_price.to_s,
      merchant_id: Item.first.merchant_id,
      created_at: Item.first.created_at,
      updated_at: Item.first.updated_at
      })
    @merchant_1 = Merchant.create(
      name: "FE Socity"
    )
    @merchant_2 = Merchant.create(
      name: "Square Earth Society"
    )
    @item_1 = Item.create(
      name: "Flat Earth Diorama",
      description: "The earth is flat.",
      unit_price: 500.99,
      merchant_id: @merchant_1.id
    )
    @item_2 = Item.create(
      name: "Cube Earth Diorama",
      description: "The earth is a cube earth and has 6 sides.",
      unit_price: 1099.49,
      merchant_id: @merchant_2.id
    )
    @item_3 = Item.first
  end

  it "can search a single item by name" do
    item_params = ({
      name: "eart"
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find?name=#{item_params[:name]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data][:attributes][:name]).to eq(@item_1.name)
    expect(item[:data][:attributes][:name]).to_not eq(@item_2.name)
  end

  it "can search a single item by description" do
    item_params = ({
      description: "EarTh"
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find?description=#{item_params[:description]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data][:attributes][:description]).to eq(@item_1.description)
    expect(item[:data][:attributes][:description]).to_not eq(@item_2.description)
  end

  it "can search multiple items by name" do
    item_params = ({
      name: "EaRt"
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find_all?name=#{item_params[:name]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data].count).to eq(2)
    expect(item[:data][0][:attributes][:name]).to eq(@item_1.name)
  end

  it "can search multiple items by description" do
    item_params = ({
      description: "eArTH"
      })
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find_all?description=#{item_params[:description]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data].count).to eq(2)
    expect(item[:data][0][:attributes][:description]).to eq(@item_1.description)
    expect(item[:data][1][:attributes][:description]).to eq(@item_2.description)
  end

  it "can search items by unit price" do
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find_all?unit_price=#{@item_params[:unit_price]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data].count).to eq(1)
    expect(item[:data][0][:attributes][:unit_price]).to eq(@item_params[:unit_price].to_f)
  end

  it "can search items by merchant id" do
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find_all?merchant_id=#{@item_params[:merchant_id]}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data].count).to eq(1)
    expect(item[:data][0][:attributes][:merchant_id]).to eq(@item_params[:merchant_id])
  end

  it "can search items by creation date" do
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find_all?created_at=#{@item_params[:created_at]}"
    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data].count).to eq(4)
    expect(items[:data][0][:attributes][:name]).to eq(@item_3.name)
  end

  it "can find a single item by date updated" do
    headers = {"CONTENT_TYPE" => "application/json"}
    get "/api/v1/items/find?updated_at=#{@item_params[:updated_at]}"
    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data][:attributes][:name]).to eq(@item_3.name)
    expect(items[:data][:attributes][:name]).to_not eq(@item_1.name)
  end
end
