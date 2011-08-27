Mapper::Application.routes.draw do
  resources :trips

  get ":marketable_url/:authentication_token" => "trips#edit"
  get ":marketable_url" => "trips#show", :as => "trip_details"
  get ":marketable_url/:authentication_token/delete" => "trips#destroy", :as => "delete_trip"

  root :to => "trips#new"
end
