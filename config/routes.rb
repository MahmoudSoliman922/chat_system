# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :v1 do
    resources :application, controller: 'app', only: %i[index create update],
                            param: :application_token do
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
