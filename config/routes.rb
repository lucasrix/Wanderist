Rails.application.routes.draw do
  root to: redirect('http://www.maplifyapp.com/')

  apipie
  mount_devise_token_auth_for User.name,
    at: 'api/v1/auth',
    controllers: {
      registrations: 'api/v1/auth/registrations',
      sessions: 'api/v1/auth/sessions',
      token_validations: 'api/v1/auth/token_validations',
      passwords: 'api/v1/auth/passwords'
    },
    skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resources :provider_sessions, only: [:create]
      end

      get :terms_of_service, to: 'texts#terms_of_service'
      get :privacy_policy, to: 'texts#privacy_policy'

      resources :story_points, only: [:index, :create, :update, :destroy]
      resources :attachments, only: [:create]

    end
  end
end
