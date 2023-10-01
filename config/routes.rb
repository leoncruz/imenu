# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :restaurants, path: :accounts

  resources :restaurants, only: :show, param: :slug do
    get 'qrcodes', to: 'qrcodes#index'

    resources :tables, shallow: true, except: :show

    get '/tables/available/:table_id', to: 'tables/check_availability#show', as: :table_check_availability
    get '/tables/select', to: 'tables/select#index', as: :select_table

    resources :menus, shallow: true, only: :edit do
      resources :categories, shallow: true do
        resources :items, shallow: true
      end
    end
  end

  patch 'shopping_carts/add', to: 'shopping_carts#create'
  get 'shopping_cart', to: 'shopping_carts#show'
  patch 'shopping_carts/:item_id/increase', to: 'shopping_carts/increase_items#update', as: :increase_shopping_cart_item
  patch 'shopping_carts/:item_id/decrease', to: 'shopping_carts/decrease_items#update', as: :decrease_shopping_cart_item
  delete 'shopping_carts/:item_id/remove', to: 'shopping_carts/remove_items#destroy', as: :remove_shopping_cart_item
end
