class Api::V1::Item::MerchantsController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(Merchant.where(id: item.merchant_id))
  end
end
