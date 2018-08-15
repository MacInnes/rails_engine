require 'rails_helper'

describe 'Invoice Single Finder API' do
  context 'GET /api/v1/invoice_items/find?paramaters' do
    it 'returns an invoice item by id' do
      id = 14
      create(:invoice_item, id: id)

      get "/api/v1/invoice_items/find?id=#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['id']).to eq(id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by item id' do
      item_id = create(:item).id
      create(:invoice_item, item_id: item_id)

      get "/api/v1/invoice_items/find?item_id=#{item_id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['item_id']).to eq(item_id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by invoice_id' do
      invoice_id = create(:invoice).id
      create(:invoice_item, invoice_id: invoice_id)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['invoice_id']).to eq(invoice_id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by quantity' do
      quantity = 237
      create(:invoice_item, quantity: quantity)

      get "/api/v1/invoice_items/find?quantity=#{quantity}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['quantity']).to eq(quantity)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by unit_price' do
      unit_price = 42312
      create(:invoice_item, unit_price: unit_price)

      get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['unit_price']).to eq((unit_price.to_f / 100).round(2).to_s)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by id' do
      id = 14
      create(:invoice_item, id: id)

      get "/api/v1/invoice_items/find?id=#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['id']).to eq(id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end

    it 'returns an invoice item by id' do
      id = 14
      create(:invoice_item, id: id)

      get "/api/v1/invoice_items/find?id=#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item['id']).to eq(id)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
    end
  end
end
