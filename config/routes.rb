SharpLink::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :passwords => "passwords", :sessions => "sessions"}
  match "/my", :to => "home#index"                                    
  match '/new/:type', :to => 'my/posts#new', :as => :new_post
  match '/categories/:parent_id/new', :to => 'my/post_categories#new', :as => :add_post_category
  match "errors/routing", :to => "errors#routing"
  match "tags/:tag/posts",  :to => "posts#show",:as => "tag_posts"
  match "/ajax/get_subjects_by_grade/:grade_id", :to => "ajax#get_subjects_by_grade"
  match "/ajax/get_cities_by_province/:province_code", :to => "ajax#get_cities_by_province"

  match "/admin", :to => "admin#index"                                     
  namespace :admin do
    resources :comments
    resources :answers
    resources :questions
    resources :users
    resource :session

    resources :posts, :pages do
      post 'preview', :on => :collection
    end

    root :to => 'dashboard#show'
  end
  
  delete 'likes/:resource_name/:resource_id' => "my/likes#destroy", :as => 'like'
  post 'likes/:resource_name/:resource_id' => "my/likes#create",  :as => 'like'
    
  scope :module => "my" do
    resources :users do 
      resources :profiles
      resources :avatars
      resources :groups
      resources :events
      resources :comments
      resources :passwords
      resources :likes
      resources :questions
      resources :collections
      resources :notifications
      resources :professions
      resources :educations
      resources :posts do
        resources :comments
      end
    end
  end

  resources :questions do
    resources :answers
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
    collection do
      get :hot
      get :active
      get :unanswered
      get :search
    end
  end
  resources :answers do
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end
  
  
  resources :tags, :only => [:index] do
    get :subscribe, :on => :member
  end
  
  resources :posts
  resources :pages
  resources :events
  resources :groups
  resources :events
  resources :tags
  resources :apps
  resources :post_categories, :controller=>"my/post_categories" do
    collection do
      get :manage
      post :rebuild
    end
  end
  resources :comments do
    collection do
      get :manage
      post :rebuild
    end
  end

  root :to => "home#index"
end
