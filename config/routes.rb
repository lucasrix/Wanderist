Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      namespace :auth do
        mount_devise_token_auth_for User.name,
                                    controllers: {
                                        registrations: 'api/v1/auth/registrations',
                                        sessions: 'api/v1/auth/sessions',
                                        token_validations: 'api/v1/auth/token_validations',
                                        passwords: 'api/v1/auth/passwords'
                                    },
                                    skip: [:omniauth_callbacks]

        resources :provider_sessions, only: [:create]
      end
    end
  end
end
