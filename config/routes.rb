Rails.application.routes.draw do
  get "bookings/index"

  get "bookings/show"

  get "bookings/new"

  get "bookings/create"

  get "bookings/edit"

  get "bookings/update"

  # You can have the root of your site routed with "root"
  root :to => "home#index"

  # Users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: "registrations" }, class_name: "FormUser"
  get "users/:id" => "users#profile"

  # Stays, rooms, bookings
  resources :stays do
    resources :rooms
    resources :bookings
  end  

  # Search stays
  get "search" => "search_stays#index"
  post "search" => "search_stays#index"

  # Bookings
  # get   "stay/:stay_id/book" => "bookings#new"
  # post  "stay/:stay_id/book" => "bookings#create"

  # Rooms bookings
  get   "stay/:stay_id/room/:room_id/book" => "bookings#new"
  post  "stay/:stay_id/room/:room_id/book" => "bookings#create"

  # Host dashboard
  get "dashboard" => "users#host_dashboard"

  resources :bookings

  # Dashboard
  # Shows next bookings (nomad)
  # Shows pending booking requests (host)
  # Shows big picture of community interaction later
  # get "dashboard"


  # New booking 
  # /bookings/new

  # Dashboard
  # 
  # See current bookings as a host
  # /host/dashboard
  # See current bookings as a nomad
  # /nomad/dashboard

  # Show
  # 
  # See a booking as a nomad
  # /nomad/booking/id
  # See and manage a booking as a host 
  # /host/booking/id



  # Example of regular route:
  #   get "products/:id" => "catalog#view"

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get "products/:id/purchase" => "catalog#purchase", as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get "short"
  #       post "toggle"
  #     end
  #
  #     collection do
  #       get "sold"
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get "recent", on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post "toggle"
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
