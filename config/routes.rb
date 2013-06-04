Forms::Plugin.routes.draw do
  extend Wheelhouse::RouteExtensions
  
  resources :forms do
    member do
      get :spam
    end
    
    resources :submissions
  end
end
