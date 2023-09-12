# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :restaurants, path: :accounts

  resources :restaurants, only: :show, param: :slug do
    resources :menus, shallow: true, except: :index do
      resources :categories, shallow: true do
        resources :items, shallow: true
      end
    end
  end
end
