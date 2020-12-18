class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant_params.each do |key, value|
      if key == "name"
        @merchants = search_name(key, value)
      else
        @merchants = search_date(key, value)
      end
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    merchant_params.each do |key, value|
      if key == "name"
        @merchants = search_name(key, value)
      else
        @merchants = search_date(key, value)
      end
    end
    render json: MerchantSerializer.new(@merchants[0])
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end

  def search_name(key, value)
    Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
  end

  def search_date(key, value)
    Merchant.all.each do |merchant|
      merchant.created_at.to_date == value.to_date
    end
  end
end
