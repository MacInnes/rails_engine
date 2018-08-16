class Api::V1::Customers::CustomerRandomController < ApplicationController

  def show
    render json: Customer.order('RANDOM()').limit(1).take
  end

end
