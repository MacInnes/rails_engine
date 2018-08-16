class Api::V1::Transactions::TransactionSearchController < ApplicationController

  def show
    render json: Transaction.find_by(transaction_search_params)
  end

  private

  def transaction_search_params
    params.permit(:id, :result, :credit_card_number, :invoice_id, :created_at, :updated_at)
  end
end
