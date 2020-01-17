Rails.application.routes.draw do

  ################
  #   Accueils   #
  ################
  root "home#index"
  get "home", to: "home#index"
  get "cyclo", to: "home#index"
  get "nursing", to: "home#index"


  ##############
  #   Groupes  #
  ##############
  #get "groupes", to: "groupes#index"
  #get "groupes/:id", to: "groupes#show"
  resources :groupes, only: [ :show, :index ]

end
