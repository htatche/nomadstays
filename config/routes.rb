Rails.application.routes.draw do

  root :to => "home#index"

  # Users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: "registrations" }, class_name: "FormUser"
  get "users/:id" => "users#profile"

  # Stays, rooms, bookings
  resources :stays do
    resources :rooms
    resources :bookings
  end  

  # Stay photos
  resources :stay_photos 
  get "stay_photos/:id/set_as_cover" => "stay_photos#set_as_cover"

  # Bookings
  get "bookings/:id/payment" => "bookings#payment"
  get "bookings/:id/pay" => "bookings#pay"

  get "bookings/:id/payment_cancelled" => "bookings#payment_cancelled"
  get "bookings/:id/payment_received" =>  "bookings#payment_received"

  get  "stay/:stay_id/room/:room_id/book" => "bookings#new"
  post "stay/:stay_id/room/:room_id/book" => "bookings#create"

  # Admin
  namespace :admin do
    resources :stays
    resources :bookings

    get "bookings/:id/accept" => "bookings#accept"
    get "bookings/:id/reject" => "bookings#reject"
    get "bookings/:id/cancel_by_host" => "bookings#cancel_by_host"
    get "bookings/:id/cancel_by_nomad" => "bookings#cancel_by_nomad"    
  end


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
