Rails.application.routes.draw do
  
  devise_for :users


  


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
  get "exports", to: "tools#exports"
  get "download_backup", to: "tools#download_backup"
  get "statistics", to: "tools#statistics"


  ####################
  #   Configuration  #
  ####################
  resources :konfigurations, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


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
  resources :blog_messages, only: [ :show, :index, :new, :edit, :create, :update, :destroy]
  resources :blog_responses, only: [ :new, :edit, :create, :update, :destroy ]
  get "blog_message_export_pdf", to: "export#blog_message_export_pdf"
  get "review_blog_message", to: "blog_messages#review"

  ################
  #  Wiki Pages  #
  ################
  resources :wiki_pages, only: [ :show, :index, :new, :edit, :create, :update, :destroy]

  #############
  #  Postits  #
  #############
  resources :postits, only: [ :show, :index, :new, :edit, :create, :update, :destroy]
  get "take_it", to: "postits#take_it"
  get "done", to: "postits#done"

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
  get "remove_one_day", to: "absences#remove_one_day"


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
  get "ical_export_ics", to: "export#ical_export_ics"


  ###################
  #   WorkingLists  #
  ###################
  resources :working_lists, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ############
  #   Works  #
  ############
  resources :works, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ############
  #   Tasks  #
  ############
  resources :tasks, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  #############
  #   Hebdos  #
  #############
  resources :hebdos, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "grille_hebdos", to: "hebdos#grille"


  
  ######## TESTS
  get "show.pdf", to: "export#show"
  get "test", to: "test#index"


  ########## Export DB
  #get "exports", to: "export#index"
  get "logbook_articles_json", to: "export#logbook_articles_json"

end
