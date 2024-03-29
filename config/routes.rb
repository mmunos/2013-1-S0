S0::Application.routes.draw do

  resources :searches, path: "/search"

  # Concerns
  ## Reviews
  concern :reviewable do 
    resources :reviews, only: [:create, :destroy, :update]
  end

  ## Reviews Action
  get "/movies/:id/reviews", to:"movies#show_reviews"
  get "/movies/:id/posts", to:"movies#show_posts"
  get "/series/:id/reviews", to:"serials#show_reviews"
  get "/series/:id/posts", to:"serials#show_posts"
  get "/series/:serial_id/seasons/:id/reviews", to: "seasons#show_reviews"
  get "/series/:serial_id/seasons/:id/posts", to: "seasons#show_posts"
  get "/series/:serial_id/seasons/:season_id/episodes/:id/reviews", to:"episodes#show_reviews"
  get "/series/:serial_id/seasons/:season_id/episodes/:id/posts", to:"episodes#show_posts"


  ## Posts
  concern :commentable do 
    resources :posts, only: [:index, :create, :destroy, :update]
  end

  # Movies
  resources :movies, concerns: [:reviewable, :commentable]

  # Series, Season and Episodes
  resources :serials, path: "/series", concerns: [:reviewable, :commentable] do
    resources :seasons, concerns: [:reviewable, :commentable] do
        resources :episodes, concerns: [:reviewable, :commentable]
    end
  end
  
  # Session Management
  resources :sessions, only: [:create, :new, :destroy]
  get "/login", to: "sessions#create", as: :log_in
  get "/logout", to: "sessions#destroy", as: :log_out
  get "/signup", to: "users#new", as: :sign_up
  match "/login", to: "sessions#create", via: :post

  # Pages
  get "403", to: "pages#no_access", as: :access_denied

  # User
  ## User shorthands
  get "/me", to: "users#me", as: :my_profile
  get "/me/shows", to:"followed_shows#shows", as: :my_shows
  get "/me/series", to:"followed_shows#serials", as: :my_serials
  get "/me/movies", to:"followed_shows#movies", as: :my_movies
  get "/me/watchlist", to:"watchlists#my_watchlist", as: :my_watchlist
  get "/me/tracking/serials/:id", to:"watched#tracking", as: :my_tracking
  get "/me/tracking/serials/:serial_id/seasons/:season_id", to:"watched#detail", as: :my_tracking_detail
  get "/me/seen", to:"watched#my_watched", as: :my_watched

  ## User Watchlist
  resources :users do
    resource :watchlists, path: "/watchlist"
  end
  resources :users do
    resource :watcheds, path: "/watched"
  end

  ## User show management
  get "/series/:id/add", to:"serials#add", as: :add_serial
  get "/series/:id/remove", to:"serials#remove", as: :remove_serial
  get "/movies/:id/add", to:"movies#add", as: :add_movie
  get "/movies/:id/remove", to:"movies#remove", as: :remove_movie
  get "/series/:id/watch", to:"serials#watch", as: :watch_serial
  get "/series/:id/unwatch", to:"serials#unwatch", as: :unwatch_serial
  get "/series/:id/seen", to:"serials#seen", as: :seen_serial
  get "/series/:id/unseen", to:"serials#unseen", as: :unseen_serial
  get "/movies/:id/watch", to:"movies#watch", as: :watch_movie
  get "/movies/:id/unwatch", to:"movies#unwatch", as: :unwatch_movie
  get "/watchlist/:id/remove", to:"watchlist#remove", as: :remove_from_watchlist
  get "/movies/:id/seen", to:"movies#seen", as: :seen_movie
  get "/movies/:id/unseen", to:"movies#unseen", as: :unseen_movie
  get "/series/:serial_id/seasons/:id/seen", to:"seasons#seen", as: :seen_season
  get "/series/:serial_id/seasons/:id/unseen", to:"seasons#unseen", as: :unseen_season
  get "/series/:serial_id/seasons/:season_id/episodes/:id/seen", to:"episodes#seen", as: :seen_episode
  get "/series/:serial_id/seasons/:season_id/episodes/:id/unseen", to:"episodes#unseen", as: :unseen_episode

  get "/me/:id/watching", to:"watched#my_watched", as: :my_watching_series
  get "/me/:id/seen/series", to:"watched#series", as: :my_seen_series
  get "/me/:id/seen/movies", to:"watched#movies", as: :my_seen_movies

  ## User tags on episodes
  match "/series/:serial_id/seasons/:season_id/episodes/:id/add_user_tags", to: "episodes#add_user_tags", via: :post
  get "/series/:serial_id/seasons/:season_id/episodes/:id/remove_user_tag/:tag_id", to: "episodes#remove_user_tag"

  # Static Pages
  ## Home
  root 'pages#index'

  # API
  namespace :api, defaults: {format: 'json'} do
    
    resources :movies do
      member do
        get 'add'
        get 'remove'
        get 'watch'
        get 'unwatch'
        get 'seen'
        get 'unseen'
        get 'reviews'
        get 'posts'
      end
    end

    resources :serials, path: "series" do
      member do
        get 'add'
        get 'remove'
        get 'watch'
        get 'unwatch'
        get 'reviews'
        get 'posts'
      end

      resources :seasons do
        member do
          get 'reviews'
          get 'posts'
        end

        resources :episodes do
          member do
            get 'seen'
            get 'unseen'
            get 'reviews'
            get 'posts'
          end
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'pages#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
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
