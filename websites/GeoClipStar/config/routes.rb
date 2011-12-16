ActionController::Routing::Routes.draw do |map|
  map.resources :stars

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #本公開で使用する観戦ページ
  #http://star.yuiseki.net/map.html
  map.connect '/map.html', :controller => "geo_clip", :action => "map"
  #本公開で使用する解説ページ
  #http://star.yuiseki.net/about.html
  map.connect '/about.html', :controller => "geo_clip", :action => "about"

  #本公開になったらコメントアウト
  #map.connect '/index.html', :controller => "geo_clip", :action => "index"
  map.connect '/top', :controller => "geo_clip", :action => "index"
  #map.connect '', :controller => "geo_clip", :action => "index"

  map.connect '/index.html', :controller => "geo_clip", :action => "index2"
  map.connect '/', :controller => "geo_clip", :action => "index2"
  map.connect '', :controller => "geo_clip", :action => "index2"

end
