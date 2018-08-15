require 'rails_helper'

describe 'Items Single Finder API' do
  context 'GET /api/v1/items/find?paramaters' do
    it 'returns an item by id' do
      id = create(:item).id

      get "/api/v1/items/find?id=#{id}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['id']).to eq(id)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by name' do
      name = create(:item).name

      get "/api/v1/items/find?name=#{name}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['name']).to eq(name)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by description' do
      description = create(:item).description

      get "/api/v1/items/find?description=#{description}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['description']).to eq(description)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by unit price' do
      unit_price = create(:item).unit_price

      get "/api/v1/items/find?unit_price=#{unit_price}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['unit_price']).to eq((unit_price.to_f / 100).round(2).to_s)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by merchant id' do
      merchant_id = create(:item).merchant_id

      get "/api/v1/items/find?merchant_id=#{merchant_id}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item['merchant_id']).to eq(merchant_id)
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by created at' do
      created_at = create(:item).created_at

      get "/api/v1/items/find?created_at=#{created_at}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns an item by updated at' do
      updated_at = create(:item).updated_at

      get "/api/v1/items/find?updated_at=#{updated_at}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end
  end

  context 'GET /api/v1/items/random' do
    it 'returns a random item' do
      create_list(:item, 3)

      get '/api/v1/items/random'

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item).to have_key('name')
      expect(item).to have_key('description')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('merchant_id')
    end
  end
end
