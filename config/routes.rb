# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registration',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :books, only: %i[index show] do
    resources :reviews, only: %i[create]
  end
  resources :checkout

  resources :order, only: %i[index update], controller: 'carts'
  resources :order_items, only: %i[create destroy update]

  post '/rate' => 'rater#create', :as => 'rate'

  scope '/account' do
    resources :order, only: %i[index show], controller: 'users/account/orders', as: 'account_order'
  end

  scope '/settings' do
    get 'privacy', to: 'users/settings/privacy#index'
    patch 'privacy', to: 'users/settings/privacy#update'

    get 'address', to: 'users/settings/address#index'
    patch 'address', to: 'users/settings/address#update'
  end
end
