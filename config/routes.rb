Rails.application.routes.draw do
  
  devise_for :users


  ###########
  ###########
  ##  API  ##
  ###########
  ###########
  namespace :api do
    get 'ping' => 'table_tennis#ping'
    
    resources :utilisateurs, only: [:index, :show]
    resources :services, only: [:index]
    resources :groupes, only: [:index]
    resources :jours, only: [:index, :show]
    resources :working_lists, only: [:index, :show]
    
  end


##############################################################################



  #####################
  #####################
  ##   APPLICATION   ##
  #####################
  #####################

  get 'ping' => 'table_tennis#ping'
  get 'ping_api' => 'table_tennis#ping_api'

  get 'help' => 'help#index'

  
  ################
  #   Accueils   #
  ################
  root "home#index"
  get "home", to: "home#index"
  get "admin", to: "home#admin"

  
  #############
  #   Tools   #
  #############
  get "tools", to: "tools#index"
  get "check_days", to: "tools#check_days"
  get "check_users", to: "tools#check_users"
  get "check_admins", to: "tools#check_admins"
  get "backup_db", to: "tools#backup_db"
  get "download_backup", to: "tools#download_backup"


  ##############
  #   Ajouts   #
  ##############
  resources :ajouts, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "ajouts/:id/valider", to: "ajouts#valider"
  get "ajouts/:id/dupliquer", to: "ajouts#dupliquer"
  get "ajouts/:id/modification", to: "ajouts#modification"


  ################
  #   Template   #
  ################
  resources :templates, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

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


  ###############
  #   messages  #
  ###############
  resources :messages, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###########
  #  Lieux  #
  ###########
  resources :lieus, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ##################
  #  Bug Repports  #
  ##################
  resources :bug_repports, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###################
  #  Blog Messages  #
  ###################
  resources :blog_messages, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  resources :blog_responses, only: [ :new, :edit, :create, :update, :destroy ]


  #####################
  #  Blog Categories  #
  #####################
  resources :blog_categories, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###################
  #   Utilisateurs  #
  ###################
  resources :utilisateurs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  #######################
  #  Absences & Congés  #
  #######################
  resources :absences, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "grille", to: "absences#grille"
  get "not_yet_validated_absences", to: "absences#not_yet_validated"
  get "validated_absences", to: "absences#validated"


  ################
  #  Fermetures  #
  ################
  resources :fermetures, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ############
  #  Events  #
  ############
  resources :events, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ##########
  #  Logs  #
  ##########
  resources :logs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]

  
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
  get "secr_pet", to: "jours#secr_pet"


  ###################
  #   WorkingLists  #
  ###################
  resources :working_lists, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ############
  #   Works  #
  ############
  resources :works, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  
  
end
