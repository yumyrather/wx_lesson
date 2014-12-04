WxCast::Application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"
  
  root :to => 'admin/home#index'
  
  namespace :payment do
    resources :alipay_payments do
      collection do
        get 'alipay_wap_notify'
        post 'alipay_wap_notify'
      end
    end
  end
  
  
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
        get 'wx_user_list'
      end
    end
    resources :wx_chapters
    resources :wx_users
    resources :users do
      member do
        get 'change_password'
        patch 'update_password'
      end
    end
    
    resources :settings
    
    resources :wx_menus do
      collection do
        get 'push'
        get 'fetch'
      end  
    end
    
    
    resources :alipay_payments
    resources :alipay_feedbacks
    
  end
  
  
  namespace :mobile do
    root :to => 'home#index'
    resources :wx_articles do
      member do
        get 'like'
        get 'share'
      end
    end
    
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
