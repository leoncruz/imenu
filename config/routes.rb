# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :restaurants, path: :accounts

  resources :restaurants, only: :show do
    resources :menus, shallow: true, except: :index
  end
end
