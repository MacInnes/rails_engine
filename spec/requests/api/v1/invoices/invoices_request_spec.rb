require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of all invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/invoices/:id' do
    it 'sends a single invoice' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['id']).to eq(id)
    end
  end

  context 'GET /api/v1/invoices/find?paramaters' do
  end

  context 'GET /api/v1/invoices/find_all?parameters' do
  end

  context 'GET /api/v1/invoices/random' do
  end

  context 'GET /api/v1/invoices/:id/transactions' do
    it 'returns a collection of associated transactions' do
    end
  end

  context 'GET /api/v1/invoices/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
    end
  end

  context 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of associated items' do
    end
  end

  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns the associated customer' do
    end
  end

  context 'GET /api/v1/invoices/:id/merchant' do
    it 'returns the associated merchant' do
    end
  end
end
