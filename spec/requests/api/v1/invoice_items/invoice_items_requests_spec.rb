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

  context 'GET /api/v1/invoice_items/find?paramaters' do
  end

  context 'GET /api/v1/invoice_items/find_all?parameters' do
  end

  context 'GET /api/v1/invoice_items/random' do
  end

  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_successful
    end
  end

  context 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
    end
  end
end
