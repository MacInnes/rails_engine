class Api::V1::Items::ItemSearchController < ApplicationController
  def index
    render json: Item.where(item_search_params)
  end

  def show
    render json: Item.find_by(item_search_params)
  end

  private

  def item_search_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
