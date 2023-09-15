Rails.application.routes.draw do
  scope '(:locale)' do
    get 'appointments/download', to: 'appointments#download', as: 'download_appointment'
    post 'clients/session', to: 'clients#create_user_session', as: 'session'
    get 'clients/session', to: 'clients#create_user_session', as: 'get_session'
    get 'clients/login', to: 'clients#login', as: 'login'

    resources :clients
    resources :doctors
    resources :appointments

    root "doctors#index"
  end
  
end
