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
end
