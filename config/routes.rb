Rails.application.routes.draw do
  root 'home#index'

  get "/404", to: "errors#not_found"
  get "/500", to: "errors#exception"

  namespace :api do
    namespace :v1 do 
      get '/apexlegends/profiles/:platform/:username', to: 'profiles#show'
      get '/apexlegends/profiles/search', to: 'profiles#search' # params platform and username
      # get '/apexlegends/profiles/search/:platform/:username', to: 'profiles#search'


    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
