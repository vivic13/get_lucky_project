Rails.application.routes.draw do
 
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	resources :projects, only:[:index,:show] do #前台只能看index和show頁面
		resources :donations, only:[:show,:new,:create], :controller =>"project_donations" do 
      member do
        post :checkout_pay2go
      end
    end
	end
	root "projects#index" 

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  post 'pay2go/return'
  post 'pay2go/notify'
	namespace :admin do
    resources :stories do 
      collection do
        get :home
      end
    end
  	resources :projects do #後台CRUD都可
      resources :donation, only:[:index], :controller =>"project_donations" 
    end
    resources :reports 
  	resources :users
    resources :tags
	end

	 #API routes path
  namespace :api, defaults:{ format: :json }do
    namespace :v1 do
      #devise_for :users
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"
      resources :users
    end
  end 
  
  

  get"/aboutus", to:"home#about", :controller => 'home'
 


end
