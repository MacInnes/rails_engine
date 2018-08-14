require 'rails_helper'

describe 'Transaction API' do
  it 'responds to /api/v1/transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.length).to eq(3)
  end
  it 'responds to /api/v1/transactions/:id' do
    merchant = Merchant.create(name: "asdf")
    customer = Customer.create(first_name: "fjk", last_name: "dsfk")
    transaction = Transaction.create(status: "shipped", merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/transactions/#{transaction.id}"

    response_transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end
end
