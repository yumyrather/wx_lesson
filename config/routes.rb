WxLesson::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"
  namespace :admin do
    root :to => 'home#index'
    resources :wx_keywords
    resources :wx_articles
  end
  
  root :to => 'admin/home#index'
end
