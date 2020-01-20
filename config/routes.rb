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
  resources :groupes, only: [ :show, :index, :new, :create ]


  ###################
  #   Utilisateurs  #
  ###################
  resources :utilisateurs, only: [ :show, :index, :new, :create ]


  ##############
  #  Absences  #
  ##############
  resources :absences, only: [ :show, :index, :new, :create ]
end
