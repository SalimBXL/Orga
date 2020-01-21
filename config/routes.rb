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
  resources :groupes, only: [ :show, :index, :new, :edit, :create, :update ]


  ###############
  #   Services  #
  ###############
  resources :services, only: [ :show, :index, :new, :edit, :create, :update ]


  #####################
  #   Types Absences  #
  #####################
  resources :type_absences, only: [ :show, :index, :new, :edit, :create, :update ]


  ###########
  #  Lieux  #
  ###########
  resources :lieus, only: [ :show, :index, :new, :edit, :create, :update ]


  ###################
  #   Utilisateurs  #
  ###################
  resources :utilisateurs, only: [ :show, :index, :new, :create ]


  ##############
  #  Absences  #
  ##############
  resources :absences, only: [ :show, :index, :new, :create ]
end
