Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: 'invoice_search#show'
        get '/find_all', to: 'invoice_search#index'
        get '/random', to: 'random_invoice#show'
      end

      scope module: :invoices do
        resources :invoices, only: [:index, :show] do
          get '/invoice_items', to: 'invoice_invoice_items#index'
          get '/items', to: 'invoice_items_relation#index'
          get '/merchant', to: 'invoice_merchant#show'
          get '/customer', to: 'invoice_customer#show'
          get '/transactions', to: 'invoice_transactions#index'
        end
      end

      namespace :items do
        get '/find', to: 'item_search#show'
        get '/find_all', to: 'item_search#index'
        get '/random', to: 'random_item#show'
        get '/most_revenue', to: 'top_revenue#index'
        get '/most_items', to: 'most_sold#index'
        get '/:item_id/best_day', to: 'best_day#show'
      end

      scope module: :items do
        resources :items, only: [:index, :show] do
          get '/merchant', to: 'item_merchant#show'
          get '/invoice_items', to: 'item_invoice_items#index'
        end
      end

      namespace :invoice_items do
        get '/find', to: 'invoice_item_search#show'
        get '/find_all', to: 'invoice_item_search#index'
        get '/random', to: 'random_invoice_item#show'
      end

      scope module: :invoice_items do
        resources :invoice_items, only: [:index, :show] do
          get '/invoice', to: 'invoice_item_invoice#show'
          get '/item', to: 'invoice_item_item#show'
        end
      end

      namespace :merchants do
        get '/most_revenue', to: 'merchant_revenue#index'
        get '/most_items', to: 'merchant_items_quantity#index'
        get '/revenue', to: 'merchant_revenue#show'
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
        get '/random', to: 'merchant_random#show'
        get '/:merchant_id/favorite_customer', to: 'favorite_customer#show'
        get '/:merchant_id/customers_with_pending_invoices', to: 'customers_with_pending_invoices#index'
        get ':merchant_id/revenue', to: 'single_merchant_revenue#show'
      end

      scope module: :merchants do
        resources :merchants, only: [:index, :show] do
          get '/items', to: 'merchant_items#index'
          get '/invoices', to: 'merchant_invoices#index'
        end
      end

      namespace :transactions do
        get '/find', to: 'transaction_search#show'
        get '/find_all', to: 'transaction_search#index'
        get '/random', to: 'transaction_random#show'
      end

      scope module: :transactions do
        resources :transactions, only: [:index, :show] do
          get '/invoice', to: 'transaction_invoice#show'
        end
      end

      namespace :customers do
        get '/find', to: 'customer_search#show'
        get '/find_all', to: 'customer_search#index'
        get '/random', to: 'customer_random#show'
        get ':customer_id/favorite_merchant', to: 'favorite_merchant#show'
      end

      scope module: :customers do
        resources :customers, only: [:index, :show] do
          get '/invoices', to: 'customer_invoices#index'
          get '/transactions', to: 'customer_transactions#index'
        end
      end
    end
  end
end
