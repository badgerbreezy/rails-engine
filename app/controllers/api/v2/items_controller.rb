class Api::V2::ItemsController < ApplicationController
  def index
    render json: Item.all
  end
end
