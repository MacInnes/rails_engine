require 'rails_helper'

describe 'Invoice Items API' do
  context 'GET /api/v1/invoice_items' do
    it 'sends a list of all invoice items' do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(response).to be_successful
      expect(invoice_items.count).to eq(3)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end
  end

  context 'GET /api/v1/invoice_items/:id' do
    it 'sends a single invoice item' do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['id']).to eq(id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end
  end

  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      invoice_id = create(:invoice).id
      invoice_item = create(:invoice_item, invoice_id: invoice_id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice['id']).to eq(invoice_id)
      expect(invoice).to have_key('customer_id')
      expect(invoice).to have_key('merchant_id')
      expect(invoice).to have_key('status')
    end
  end

  context 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
      item_id = create(:item).id
      invoice_item = create(:invoice_item, item_id: item_id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['id']).to eq(item_id)
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end
end
