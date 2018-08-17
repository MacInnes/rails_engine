class Api::V1::Customers::CustomerSearchController < ApplicationController
  def show
    render json: Customer.find_by(customer_search_params)
  end

  def index
    render json: Customer.where(customer_search_params)
  end

  private

  def customer_search_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
