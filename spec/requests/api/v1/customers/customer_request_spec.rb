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
end
