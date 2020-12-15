require 'rails_helper'

describe "Items API" do
  it "can send a list of items" do
    create_list(:item, 4)

    get '/api/v1/items'

    expect(response).to be_successful
  end
end
