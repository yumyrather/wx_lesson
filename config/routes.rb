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
    resources :wx_lessons
    resources :wx_chapters
    resources :wx_users
    
  end
  
  
  namespace :mobile do
    root :to => 'home#index'
    resources :wx_articles
  
  end
  
end
