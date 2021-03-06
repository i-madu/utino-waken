Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲスト用
  devise_scope :customer do
    post "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
  end

  scope module: :public do
    root "homes#top"
    resources :customers, only:[:show,:edit,:update] do
      resource :relationships, only:[:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"
      collection do
        get "search", to: "customers#search"
      end
      member do
        #退会確認用
        get "unsubscribe"
        #退会削除用
        patch "withdrawal"
      end
    end
    resources :posts,only:[:index,:show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
    end
    get "search_tag", to:"posts#search_tag"



  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update] do
      collection do
        get "search", to: "customers#search"
      end
      resources :posts, only:[:index, :show, :destroy] do
        resources :comments, only:[:destroy]
      end
    end
    resources :tags, only:[:index, :destroy]
  end







  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
