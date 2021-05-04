# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :user, only: [] do
        collection do
          post :login
          get :logout
          get :ping_role
        end
      end

      get "get_type_event", to: "event#get_type_event"
      resources :event, only: [:index, :show], param: :uid do
        collection do
          get :joined_event
        end

        resources :token, only: [], module: :event do
          collection do
            get :qr_code
          end
        end

        resources :take_part_in_event, only: [:create], module: :event do
          # collection do
          #   get :list_attendance
          # end
        end
      end

      resources :tokens, only: [], param: :token_string do
        member do
          get :attendance_by_qr_code
        end
      end

      scope module: :admin do
        resources :event, only: [], param: :event_uid do
          member do
            patch :approve_event
            patch :cancel_event
          end
        end
      end

      namespace :admin do
        resources :user, only: [:index], param: :uid do
          member do
            get :ban
            get :unban
            get :creator
            get :approval
            get :staff
          end
        end
      end

      scope module: :creator do
        resources :event, only: [:create], param: :uid do
          collection do
            get "management/list_event", to: "event#index"
          end
          resources :take_part_in_event, only: [], module: :event do
            collection do
              get :list_attendance
            end
          end
          resources :token, only: [:create], module: :event
        end
      end
    end
  end
end
