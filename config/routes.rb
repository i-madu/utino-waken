Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #ゲスト用
  devise_scope :customers do
    post "customers/guest_sign_in", to:"customers/sessions#guest_sign_in"
  end
  
  
  
  scope module: :public do
    root "homes#top" 
    get "customers/my_posts" => "customers#show", as:"my_posts"
    patch "customers/withdraw" => "customers#withdraw",as:"withdraw_customer"
    put "customers/withdraw" => "customers#withdraw"
    resources :customers,only:[:edit,:update]
    
    resources :posts,only:[:index,:show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only:[:index, :edit, :update, :destroy]
      resource :favorites, only:[:create, :destroy]
    end
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :customers,only:[:index, :show, :edit, :update]
    resources :posts,only:[:index, :show, :destroy] do
      resources :comments,only:[:index, :destroy]
    end
  end
  
  
  
  



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
