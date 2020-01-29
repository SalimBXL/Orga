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
  resources :groupes, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


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


  ###################
  #   Semaines  #
  ###################
  resources :semaines, only: [ :show, :index, :new, :edit, :create, :update, :destroy ], param: :identifier
  get "semaines_this_week", to: "semaines#this_week"
  get "semaines_utilisateur/:id", to: "semaines#semaines_utilisateur"


  ###################
  #   Jobs  #
  ###################
  resources :jobs, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "jobs_this_week", to: "jobs#this_week"
  get "jobs_semaine/:id", to: "jobs#jobs_semaine"


  ###################
  #   WorkingLists  #
  ###################
  resources :working_lists, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]


  ###################
  #   Works  #
  ###################
  resources :works, only: [ :show, :index, :new, :edit, :create, :update, :destroy ]
  get "works_groupe/:id", to: "works#works_groupe"
  get "works_job/:id", to: "works#works_job"
end
