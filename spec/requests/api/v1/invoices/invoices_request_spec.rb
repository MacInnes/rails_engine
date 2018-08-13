require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_successful
    end
  end
end
