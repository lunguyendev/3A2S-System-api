# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :user, only: [] do
        collection do
          post :login
          get :logout
        end
      end

      resources :event, only: [:index, :create, :show], param: :uid do
        member do
          get :join_event
          post :generate_qr_code
          get :qr_code
        end
      end
    end
  end
end
