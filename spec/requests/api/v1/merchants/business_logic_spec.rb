require 'rails_helper'

describe "merchant business logic" do
  it 'responds to /api/v1/merchants/most_revenue?quantity=x correctly' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    customer = create(:customer)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)

    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/most_revenue?quantity=2'

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.count).to eq(2)
    expect(response_merchants.first["id"]).to eq(merchant_1.id)
    expect(response_merchants.first["name"]).to eq(merchant_1.name)
  end

  it 'responds to /api/v1/merchants/most_items?quantity=x correctly' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/most_items?quantity=2'

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.count).to eq(2)
    expect(response_merchants.first["id"]).to eq(merchant_1.id)
    expect(response_merchants.first["name"]).to eq(merchant_1.name)
  end

  it 'responds to /api/v1/merchants/revenue?date=x' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)

    bad_date = "2017-08-13".to_date

    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id, created_at: bad_date)

    create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
    create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, result: 'failed', invoice_id: invoice_3.id)

    get '/api/v1/merchants/revenue?date=2018-08-13'

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_total["total_revenue"]).to eq("800.00")
  end

  context 'GET /api/v1/merchants/:id/favorite_customer' do
    it 'returns the customer who has conducted the most total number of successful transactions' do
      merchant = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id, merchant_id: merchant.id, created_at: bad_date)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, result: 'failed', invoice_id: invoice_3.id)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer['id']).to eq(customer_1.id)
      expect(customer['first_name']).to eq(customer_1.first_name)
      expect(customer['last_name']).to eq(customer_1.last_name)
    end
  end

  context 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns a collection of customers which have pending invoices' do
      merchant = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)

      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)

      bad_date = "2017-08-13".to_date

      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id, merchant_id: merchant.id, created_at: bad_date)

      create_list(:invoice_item, 5, item_id: item_1.id, invoice_id: invoice_1.id)
      create_list(:invoice_item, 3, item_id: item_2.id, invoice_id: invoice_2.id)
      create_list(:invoice_item, 1, item_id: item_3.id, invoice_id: invoice_3.id)

      create(:transaction, invoice_id: invoice_1.id, result: 'failed')
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customers = JSON.parse(response.body)
      customer = customers.first

      expect(response).to be_successful
      expect(customers.count).to eq(1)
      expect(customer['id']).to eq(customer_1.id)
      expect(customer['first_name']).to eq(customer_1.first_name)
      expect(customer['last_name']).to eq(customer_1.last_name)
    end
  end
  it 'responds to /api/v1/merchants/:id/revenue' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice.id)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_total["revenue"]).to eq("500.00")
  end
  it 'responds to /api/v1/merchants/:id/revenue?date=x' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)

    bad_date = "2017-08-13".to_date

    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: bad_date)
    create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice_1.id)
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=2018-08-13"

    response_total = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_total["revenue"]).to eq("500.00")
  end
end
