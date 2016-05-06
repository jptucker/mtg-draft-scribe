Rails.application.routes.draw do

    get("/", { :controller => "drafts", :action => "index" })

  # Routes for the Selection resource:
  # CREATE
  get '/selections/new', controller: 'selections', action: 'new', as: 'new_selection'
  post '/selections', controller: 'selections', action: 'create', as: 'selections'

  # READ
  get '/selections', controller: 'selections', action: 'index'
  get '/selections/:id', controller: 'selections', action: 'show', as: 'selection'

  # UPDATE
  get '/selections/:id/edit', controller: 'selections', action: 'edit', as: 'edit_selection'
  patch '/selections/:id', controller: 'selections', action: 'update'

  # DELETE
  delete '/selections/:id', controller: 'selections', action: 'destroy'
  #------------------------------

  # Routes for the Draft resource:
  # CREATE
  get '/drafts/new', controller: 'drafts', action: 'new', as: 'new_draft'
  post '/drafts', controller: 'drafts', action: 'create', as: 'drafts'

  # READ
  get '/drafts', controller: 'drafts', action: 'index'
  get '/drafts/:id', controller: 'drafts', action: 'show', as: 'draft'

  # UPDATE
  get '/drafts/:id/edit', controller: 'drafts', action: 'edit', as: 'edit_draft'
  patch '/drafts/:id', controller: 'drafts', action: 'update'

  # DELETE
  delete '/drafts/:id', controller: 'drafts', action: 'destroy'
  #------------------------------

  # Routes for the Card resource:
  get '/cards/search', controller: 'cards', action: 'search'
  get '/cards/add', controller: 'cards', action: 'add'

  # CREATE
  get '/cards/new', controller: 'cards', action: 'new', as: 'new_card'
  post '/cards', controller: 'cards', action: 'create', as: 'cards'

  # READ
  get '/cards', controller: 'cards', action: 'index'
  get '/cards/:id', controller: 'cards', action: 'show', as: 'card'

  # UPDATE
  get '/cards/:id/edit', controller: 'cards', action: 'edit', as: 'edit_card'
  patch '/cards/:id', controller: 'cards', action: 'update'

  # DELETE
  delete '/cards/:id', controller: 'cards', action: 'destroy'

  #------------------------------

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :cardss
  resources :drafts
  resources :selections

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
