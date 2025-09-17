Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Swagger UI / OpenAPI docs
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  # ===== AfriStream API =====
  namespace :auth do
    post "register", to: "users#register"
    post "login", to: "users#login"
    delete "logout", to: "users#logout"
    get "whoami", to: "users#whoami"
  end

  namespace :creator do
    post "upload", to: "contents#create"
    get "dashboard", to: "contents#dashboard"
  end

  namespace :fan do
    get "content", to: "contents#index"
    post "purchase/:id", to: "transactions#create"
    get "library", to: "transactions#library"
  end

  namespace :admin do
    get "royalties", to: "royalties#index"
  end

  resources :subtitles, only: [:show] # GET /subtitles/:id?lang=fr
  resources :licenses, only: [:create, :show]

  namespace :meta do
    get "countries", to: "countries#index"
    get "countries_with_codes", to: "countries#with_codes"
    get "phone_mask/:country", to: "countries#phone_mask"
  end
end
