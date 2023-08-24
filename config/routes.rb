Rails.application.routes.draw do
  get 'appointments/download', to: 'appointments#download', as: 'download_appointment'
  post 'appointments/list', to: 'appointments#list', as: 'list_appointment'

  resources :clients
  resources :doctors
  resources :appointments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "doctors#index"
end
