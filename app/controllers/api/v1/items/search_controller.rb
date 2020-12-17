class Api::V1::Items::SearchController < ApplicationController
  def index
    item_params.each do |key, value|
      if key == "unit_price"
        @items = Item.where("#{key} = ?", "#{value.to_f}")
      elsif key == "merchant_id"
        @items = Item.where("#{key} = ?", "#{value.to_i}")
      elsif key == "name" || key == "description"
        @items = Item.where("lower(#{key}) like ?", "%#{value.downcase}%")
      else key == "created_at" || key == "updated_at"
        @items = Item.all.each do |item|
          "item.#{key}.to_date" == "#{value.to_date}"
        end
      end
    end
    render json: ItemSerializer.new(@items)
  end

  def show
    item_params.each do |key, value|
      if key == "unit_price"
        @items = Item.where("#{key} = ?", "#{value.to_f}")
      elsif key == "merchant_id"
        @items = Item.where("#{key} = ?", "#{value.to_i}")
      elsif key == "name" || key == "description"
        # binding.pry
        @items = Item.where("lower(#{key}) like ?", "%#{value.downcase}%")
      else key == "created_at" || key == "updated_at"
        @items = Item.all.each do |item|
          "item.#{key}.to_date" == "#{value.to_date}"
        end
      end
    end
    render json: ItemSerializer.new(@items[0])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
