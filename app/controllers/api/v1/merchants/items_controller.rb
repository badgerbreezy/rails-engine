class Api::V1::Merchant::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(merchant_id: params[:id]))
  end
end
