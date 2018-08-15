require 'rails_helper'

describe 'Item Multi Finder API' do
  context 'GET /api/v1/items/find_all?paramaters' do
    it 'returns all items by id' do
      id = create(:item).id

      get "/api/v1/items/find_all?id=#{id}"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(1)
      expect(item['id']).to eq(id)
      expect(item).to have_key('name')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns all items by name' do
      valid_name = 'Item Qui Esse'
      invalid_name = 'Item Autem Minima'
      create_list(:item, 3, name: valid_name)
      create_list(:item, 3, name: invalid_name)

      get "/api/v1/items/find_all?name=#{valid_name}"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(3)
      expect(item['name']).to eq(valid_name)
      expect(item).to have_key('name')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns all items by description' do
      valid_description = 'Nihil autem sit odio inventore deleniti.'
      invalid_description = 'Cumque consequuntur ad.'
      create_list(:item, 3, description: valid_description)
      create_list(:item, 3, description: invalid_description)

      get "/api/v1/items/find_all?description=#{valid_description}"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(3)
      expect(item['description']).to eq(valid_description)
      expect(item).to have_key('name')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    it 'returns all items by unit price' do
      valid_unit_price = 75107
      invalid_unit_price = 67076
      create_list(:item, 3, unit_price: valid_unit_price)
      create_list(:item, 3, unit_price: invalid_unit_price)

      get "/api/v1/items/find_all?unit_price=#{valid_unit_price}"

      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(3)
      expect(item['unit_price']).to eq((valid_unit_price.to_f / 100).round(2).to_s)
      expect(item).to have_key('name')
      expect(item).to have_key('unit_price')
      expect(item).to have_key('description')
      expect(item).to have_key('merchant_id')
    end

    # it 'returns all items by merchant id' do
    #   merchant_id = create(:item).merchant_id
    #
    #   get "/api/v1/items/find_all?merchant_id=#{merchant_id}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item['merchant_id']).to eq(merchant_id)
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by created at' do
    #   created_at = create(:item).created_at
    #
    #   get "/api/v1/items/find_all?created_at=#{created_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
    #
    # it 'returns all items by updated at' do
    #   updated_at = create(:item).updated_at
    #
    #   get "/api/v1/items/find_all?updated_at=#{updated_at}"
    #
    #   item = JSON.parse(response.body)
    #
    #   expect(response).to be_successful
    #   expect(item).to have_key('unit_price')
    #   expect(item).to have_key('description')
    #   expect(item).to have_key('merchant_id')
    # end
  end
end
