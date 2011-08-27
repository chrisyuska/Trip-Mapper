Mapper::Application.routes.draw do
  resources :trips

  get ":marketable_url" => "trips#show", :as => "trip_details"

  root :to => "trips#new"
end
