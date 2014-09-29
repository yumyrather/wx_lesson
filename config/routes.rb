WxCast::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"
  
  root :to => 'admin/home#index'

  namespace :admin do
    root :to => 'home#index'
    resources :wx_keywords do
      member do 
        get 'wx_article_list'
      end
    end
    resources :wx_keyword_items
    resources :wx_articles
    
    
    # LESSON PART
    resources :wx_lessons do
      member do
        get 'wx_chapter_list'
      end
    end
    resources :wx_chapters
    resources :wx_users
    
  end
  
  
  namespace :mobile do
    root :to => 'home#index'
    resources :wx_articles
    
    resources :wx_lessons 
    resources :wx_chapters
    resources :wx_users,:only=>[:show]
    
    
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup',    to: 'users#new',              via: 'get'
    match '/signin',    to: 'sessions#new',           via: 'get'
    match '/signout',   to: 'sessions#destroy',       via: 'delete'
    match '/index',     to: 'home#index',             via: 'get'
  end
  
end
