class Api::V1::Items::SearchController < ApplicationController
  def index
    item_params.each do |key, value|
      if key == "unit_price"
        @items = search_price(key, value)
      elsif key == "merchant_id"
        @items = search_merchant_id(key, value)
      elsif key == "name" || key == "description"
        @items = search_name_desc(key, value)
      else key == "created_at" || key == "updated_at"
        @items = search_date(key, value)
      end
    end
    render json: ItemSerializer.new(@items)
  end

  def show
    item_params.each do |key, value|
      if key == "unit_price"
        @items = search_price(key, value)
      elsif key == "merchant_id"
        @items = Item.where("#{key} = ?", "#{value.to_i}")
      elsif key == "name" || key == "description"
        @items = search_name_desc(key, value)
      else key == "created_at" || key == "updated_at"
        @items = search_date(key, value)
      end
    end
    render json: ItemSerializer.new(@items[0])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def search_price(key, value)
    Item.where("#{key} = ?", "#{value.to_f}")
  end

  def search_merchant_id(key, value)
    Item.where("#{key} = ?", "#{value.to_i}")
  end

  def search_name_desc(key, value)
    Item.where("lower(#{key}) like ?", "%#{value.downcase}%")
  end

  def search_date(key, value)
    Item.all.each do |item|
      "item.#{key}.to_date" == "#{value.to_date}"
    end
  end
end
