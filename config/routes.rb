Rails.application.routes.draw do
  root to: redirect('http://www.maplifyapp.com/')

  put 'reports/:report_id', to: 'blockings#update', as: :blockings
  get 'reports/:report_id', to: 'blockings#edit', as: :update_blocked

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


  get :share, to: 'shared_links#share'
  get :edit_password, to: 'shared_links#edit_password'

  namespace :api do
    namespace :v1 do
      namespace :auth do
        resources :provider_sessions, only: [:create]
      end

      get :about, to: 'texts#about'
      get :terms_of_service, to: 'texts#terms_of_service'
      get :privacy_policy, to: 'texts#privacy_policy'

      concern :likeable do
        resource :like, only: [:create, :destroy]
      end

      concern :reportable do
        resource :report, only: [:create]
      end

      concern :followable do
        resource :following, only: [:create, :destroy]
      end

      resources :story_points, concerns: [:likeable, :reportable], only: [:index, :show, :create, :update, :destroy] do
        resources :stories, only: [:index]
      end

      resources :users, concerns: [:followable], only: [:index] do
        resources :story_points, only: [:index]
        resources :stories, only: [:index]
      end

      resource :user, scope: 'current_user', only: [:update] do
        resources :story_points, only: [:index]
        resources :stories, only: [:index]
        get :followed
        get :followers
      end

      resources :attachments, only: [:create]
      resources :stories, concerns: [:likeable, :followable, :reportable], only: [:index, :show, :create, :update, :destroy] do
        resources :story_points, only: [:index]
      end

      get :discover, to:  'discovers#discover'

      resource :profile, only: [:show, :update]
      resources :profiles, only: [:show]
      resources :locations, only: [] do
        collection do
          get :cities
        end
      end

      resources :gadgets, only: [:create, :destroy]
      resources :notifications, only: :index
    end
  end
end
