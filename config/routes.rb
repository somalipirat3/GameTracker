Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do 
      get '/apexlegends/:platform/:username', to: 'apexlegends#index'
      get '/apexlegends/search/:platform/:username', to: 'apexlegends#search'
      get '/apexlegends/profile/:platform/:username', to: 'apexlegends#profile'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
