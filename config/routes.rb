WxLesson::Application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"
  namespace :admin do
    root :to => 'home#index'
    resources :wx_keywords
  end
  
  root :to => 'admin/home#index'
end
