class Api::V1::Items::RandomItemController < ApplicationController
  def show
    render json: Item.order('RANDOM()').limit(1).take
  end
end
