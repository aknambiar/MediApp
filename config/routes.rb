Rails.application.routes.draw do
  scope '(:locale)' do
    get 'appointments/download', to: 'appointments#download', as: 'download_appointment'
    post 'appointments/list', to: 'appointments#list', as: 'list_appointment'

    resources :clients
    resources :doctors
    resources :appointments

    root "doctors#index"
  end
  
end
