Rails.application.routes.draw do
  scope '(:locale)' do
    resources :clients do
      collection do
        get 'login', to: 'clients#login', as: 'login'
        get 'session', to: 'clients#create_user_session', as: 'get_session'
        post 'session', to: 'clients#create_user_session', as: 'session'
      end
    end

    resources :doctors

    resources :appointments do
      collection do
        get 'download', to: 'appointments#download', as: 'download_appointment'
      end
    end

    root "doctors#index"
  end
end
