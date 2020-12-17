class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant_params.each do |key, value|
      if key == "name"
        @merchants = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
      else
        @merchants = Merchant.all.each do |merchant|
          merchant.created_at.to_date == value.to_date
        end
        # Merchant.where("#{key} = ?", "#{value.to_date}")
      end
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    merchant_params.each do |key, value|
      if key == "name"
        @merchants = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
      else
        @merchants = Merchant.all.each do |merchant|
          merchant.created_at.to_date == value.to_date
        end
      end
    end
    render json: MerchantSerializer.new(@merchants[0])
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
