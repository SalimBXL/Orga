Rails.application.routes.draw do
  
  devise_for :users
  ###########
  ###########
  ##  API  ##
  ###########
  ###########
  namespace :api do
    get 'ping' => 'table_tennis#ping'
    
    resources :utilisateurs, only: :index

    
  end


##############################################################################



  #####################
  #####################
  ##   APPLICATION   ##
  #####################
  #####################

  get 'ping' => 'table_tennis#ping'
  get 'ping_api' => 'table_tennis#ping_api'

  
  ################
  #   Accueils   #
  ################
  root "home#index"
  get "home", to: "home#index"
  get "admin", to: "home#admin"




  ##############
  #   Ajouts   #
  ##############
  resources :ajouts, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "ajouts/:id/valider", to: "ajouts#valider"
  get "ajouts/:id/dupliquer", to: "ajouts#dupliquer"


  ##############
  #   Groupes  #
  ##############
  resources :groupes, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ##############
  #   Classes  #
  ##############
  resources :classes, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###############
  #   Services  #
  ###############
  resources :services, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###########
  #  Lieux  #
  ###########
  resources :lieus, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###################
  #   Utilisateurs  #
  ###################
  resources :utilisateurs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  #######################
  #  Absences & Congés  #
  #######################
  resources :absences, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  resources :demande_conges, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ################
  #  Fermetures  #
  ################
  resources :fermetures, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ############
  #  Events  #
  ############
  resources :events, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]

  
  #####################
  #   Types Absences  #
  #####################
  resources :type_absences, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ############
  #   Jours  #
  ############
  resources :jours, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "today", to: "jours#specific_day"
  get "week", to: "jours#specific_week"
  get "month", to: "jours#specific_month"


  ###################
  #   WorkingLists  #
  ###################
  resources :working_lists, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ############
  #   Works  #
  ############
  resources :works, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  
  
end
