class Api::V1::Transactions::TransactionInvoiceController < ApplicationController

  def show
    render json: Transaction.includes(:invoice).find(params[:transaction_id]).invoice
  end

end
