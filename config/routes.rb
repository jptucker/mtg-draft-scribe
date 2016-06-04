Rails.application.routes.draw do
  #------------------------------

  get("/", { :controller => "drafts", :action => "index" })

  # Routes for the Cardset resource (kept as a sample):
  # CREATE
  # get '/cardsets/new', controller: 'cardsets', action: 'new', as: 'new_cardset'
  # post '/cardsets', controller: 'cardsets', action: 'create', as: 'cardsets'

  # READ
  # get '/cardsets', controller: 'cardsets', action: 'index'
  # get '/cardsets/:id', controller: 'cardsets', action: 'show', as: 'cardset'

  # UPDATE
  # get '/cardsets/:id/edit', controller: 'cardsets', action: 'edit', as: 'edit_cardset'
  # patch '/cardsets/:id', controller: 'cardsets', action: 'update'

  # DELETE
  # delete '/cardsets/:id', controller: 'cardsets', action: 'destroy'
  #------------------------------

  # Routes for the Selection resource:
  # DELETE
  get '/delete_selection/:id', controller: 'selections', action: 'delete'
  #------------------------------

  # Routes for the Draft resource:
  # CREATE
  post '/drafts', controller: 'drafts', action: 'create', as: 'drafts'

  # READ
  get '/drafts', controller: 'drafts', action: 'index'
  get '/drafts/:id', controller: 'drafts', action: 'show'

  # DELETE
  delete '/drafts/:id', controller: 'drafts', action: 'destroy'
  #------------------------------

  # Routes for the Card resource:
  get '/cards/add', controller: 'cards', action: 'add'
  get '/cards/sideboard', controller: 'cards', action: 'sideboard'

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
  resources :cards
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
