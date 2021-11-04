# frozen_string_literal: true

Rails.application.routes.draw do
  post 'users/create'
  namespace :api do
    namespace :v1 do
      get 'integer', to: 'user_integers#show'
      put 'integer/increment', to: 'user_integers#increment'
      put 'integer', to: 'user_integers#update'
    end
  end
end
