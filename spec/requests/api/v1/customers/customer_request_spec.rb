require 'rails_helper'

describe 'Customer API' do
  it 'responds to /api/v1/customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.length).to eq(3)
  end
  it 'responds to /api/v1/customer/:id' do
    customer = Customer.create(first_name: "asdf", last_name: "fkjhd")

    get "/api/v1/customers/#{customer.id}"

    response_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(response_customer["name"]).to eq(customer[:name])
  end
  it 'responds to /api/v1/customers/:id/invoices' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/customers/#{customer.id}/invoices"

    response_invoices = JSON.parse(response.body)
    first_invoice = response_invoices.first

    expect(response).to be_successful
    expect(response_invoices.length).to eq(3)
    expect(first_invoice["customer_id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/:id/transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    transactions = create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    response_transactions = JSON.parse(response.body)
    first_transaction = response_transactions.first

    expect(response).to be_successful
    expect(response_transactions.count).to eq(3)
    expect(first_transaction["invoice_id"]).to eq(invoice.id)
  end

  it 'responds to /api/v1/customers/find?id=x' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find?first_name=x' do
    customer = create(:customer, first_name: "asdf")

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find?last_name=x' do
    customer = create(:customer, last_name: "asdf")

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find?created_at=x' do
    customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/customers/find?updated_at=x' do
    customer = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/customers/find_all?id=x' do
    customer = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer.id}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer.first["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find_all?first_name=x' do
    customer = create(:customer, first_name: "asdf")
    customer_2 = create(:customer, first_name: "asdf")

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer.length).to eq(2)
    expect(response_customer.first["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find_all?last_name=x' do
    customer = create(:customer, last_name: "asdf")
    customer_2 = create(:customer, last_name: "asdf")

    get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer.length).to eq(2)
    expect(response_customer.first["id"]).to eq(customer.id)
  end
  it 'responds to /api/v1/customers/find_all?created_at=x' do
    customer = create(:customer, created_at: "123")
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?created_at=#{customer.created_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer.length).to eq(1)
    expect(response_customer.first["id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/customers/find_all?updated_at=x' do
    customer = create(:customer, updated_at: "123")
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?updated_at=#{customer.updated_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer.length).to eq(1)
    expect(response_customer.first["id"]).to eq(customer.id)
  end

  it 'responds to /api/v1/customers/random' do
    create_list(:customer, 4)

    get '/api/v1/customers/random'

    expect(response).to be_successful
  end
end
