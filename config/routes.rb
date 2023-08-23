Rails.application.routes.draw do
  resources :clients
  resources :doctors
  resources :appointments
  post '/appointments/list', to: 'appointments#list', as: 'list_appointment'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "doctors#index"
end
