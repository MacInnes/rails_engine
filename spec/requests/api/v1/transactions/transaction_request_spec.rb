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

    merchant = Merchant.create(name: "sadf")
    customer = Customer.create(first_name: "asdf", last_name: "sfdjk")
    invoice = Invoice.create(merchant_id: merchant.id, customer_id: customer.id, status: "shipped")
    transaction = Transaction.create(invoice_id: invoice.id, credit_card_number: 1234, result: "sadf")

    get "/api/v1/transactions/#{transaction.id}"

    response_transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end

  it 'responds to /api/v1/transactions/:id/invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction.invoice_id).to eq(invoice["id"])
  end

  it 'responds to /api/v1/transactions/find?id=x' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end
  it 'responds to /api/v1/transactions/find?result=x' do
    result = "asdf"
    transaction = create(:transaction, result: result)

    get "/api/v1/transactions/find?result=#{result}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end
  it 'responds to /api/v1/transactions/find?credit_card_number=x' do
    credit_card_number = "123"
    transaction = create(:transaction, credit_card_number: credit_card_number)

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end
  it 'responds to /api/v1/transactions/find?credit_card_expiration_date=x' do
    credit_card_expiration_date = "123"
    transaction = create(:transaction, credit_card_expiration_date: credit_card_expiration_date)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{credit_card_expiration_date}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end
  it 'responds to /api/v1/transactions/find?invoice_id=x' do
    invoice_id = create(:invoice).id
    transaction = create(:transaction, invoice_id: invoice_id)

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction.id)
  end


end
