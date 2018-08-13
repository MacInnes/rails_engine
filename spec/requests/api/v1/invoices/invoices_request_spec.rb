require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of invoices' do
      create_list(:customer, 1)
      create_list(:merchant, 1)
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
    end
  end
end
