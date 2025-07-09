Rails.application.routes.draw do
  get "admin/dashboard"
  get "admin/analytics"
  get "admin/users"
  get "account/profile"
  get "account/settings"
  get "account/history"
  get "bookings/new"
  get "bookings/create"
  get "bookings/show"
  get "bookings/index"
  get "pages/about"
  get "pages/contact"
  get "pages/pricing"
  get "pages/faq"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
