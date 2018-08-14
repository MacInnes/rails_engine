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
      invoice_id = create(:invoice).id
      create_list(:invoice_item, 3, invoice_id: invoice_id)

      get "/api/v1/invoices/#{invoice_id}/invoice_items"

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(response).to be_successful
      expect(invoice_items.count).to eq(3)
      expect(invoice_item['invoice_id']).to eq(invoice_id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end
  end

  context 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of associated items' do
      invoice_id = create(:invoice).id
      item_id = create(:item).id
      create_list(:invoice_item, 3, invoice_id: invoice_id, item_id: item_id)

      get "/api/v1/invoices/#{invoice_id}/items"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.count).to eq(3)
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/invoices/:id/customer' do
    xit 'returns the associated customer' do
    end
  end

  context 'GET /api/v1/invoices/:id/merchant' do
    xit 'returns the associated merchant' do
    end
  end
end
