Rails.application.routes.draw do
  resources :posts, only: %i[create index] do
    get :ip_list, on: :collection
  end
  resources :ratings, only: %i[create index]
end
