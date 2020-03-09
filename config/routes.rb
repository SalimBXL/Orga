Rails.application.routes.draw do
  
  ###########
  ###########
  ##  API  ##
  ###########
  ###########
  namespace :api do
    get 'ping' => 'table_tennis#ping'
    
    resources :semaines, only: [ :show, :index ], param: :identifier
    resources :utilisateurs, only: :index

    # Détails pour un jour en particulier
    get "jour", to: "semaines#jour" # Aujourd'hui
    get "jour/:date", to: "semaines#jour" # Jour spécifié

    # Planning de la semaine (sans détails)
    get "semaine", to:"semaines#semaine"  # Semaine courante
    get "semaine/:numero_semaine", to:"semaines#semaine"  # Semaine spécifiée

    #get "semaines/:id/utilisateurs", to: "semaines#utilisateurs"
    #get "utilisateurs/:id/semaine", to: "utilisateurs#semaine"
    
  end


##############################################################################



  #####################
  #####################
  ##   APPLICATION   ##
  #####################
  #####################

  get 'ping' => 'table_tennis#ping'
  get 'ping_api' => 'table_tennis#ping_api'

  #get 'new' => 'home#new'
  resources :ajouts, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ################
  #   Accueils   #
  ################
  root "home#index"
  get "home", to: "home#index"
  get "cyclo", to: "home#index"
  get "nursing", to: "home#index"


  ###############
  #   Agendas   #
  ###############
  get "agenda", to: "agendas#all"
  get "agendas", to: "agendas#index"
  get "agendas/absences", to: "agendas#absences"
  get "agendas/conges", to: "agendas#conges"
  get "agendas/semaines", to: "agendas#semaines"
  get "agendas/jobs", to: "agendas#jobs"
  get "agendas/jours", to: "agendas#jours"
  get "agendas/jour", to: "agendas#un_jour"


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
  get "services_lieu/:id", to: "services#services_lieu"


  #####################
  #   Types Absences  #
  #####################
  resources :type_absences, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###########
  #  Lieux  #
  ###########
  resources :lieus, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ############
  #  Congés  #
  ############
  resources :conges, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###################
  #   Utilisateurs  #
  ###################
  resources :utilisateurs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "utilisateurs_service/:id", to: "utilisateurs#utilisateurs_service"
  get "utilisateurs_groupe/:id", to: "utilisateurs#utilisateurs_groupe"


  ##############
  #  Absences  #
  ##############
  resources :absences, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  

  ###############
  #   Semaines  #
  ###############
  resources :semaines, only: [ :show, :index, :new, :edit, :create, :update, :destroy ], param: :identifier
  get "semaines_utilisateur/:id", to: "semaines#semaines_utilisateur"


  ###########
  #   Jobs  #
  ###########
  resources :jobs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "jobs_semaine/:id", to: "jobs#jobs_semaine"
  get "jobs/new/:id", to: "jobs#new"


  ###################
  #   WorkingLists  #
  ###################
  resources :working_lists, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "working_lists_job/:id", to: "working_lists#working_lists_job"
  get "working_lists_work/:id", to: "working_lists#working_lists_work"
  get "working_lists/new/:id", to: "working_lists#new"

  ############
  #   Works  #
  ############
  resources :works, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "works_groupe/:id", to: "works#works_groupe"
  get "works_classe/:id", to: "works#works_classe"
  
end
