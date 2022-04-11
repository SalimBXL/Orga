class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :checkCurrentUserIsLogged
  before_action :set_locale
  before_action :set_page_aide
  before_action :add_log_repport


  def set_postit_utilisateur
    @postit.utilisateur = current_user.utilisateur if @postit.utilisateur.nil?
  end

  def set_postit_level
    @postit.level = 1 if @postit.level.nil?
  end


  def is_manager?
    current_user.utilisateur.admin unless current_user.nil?
  end

  def is_super_admin?
    current_user.admin unless current_user.nil?
  end

  def is_manager_or_super_admin?
    (is_super_admin? or is_manager?) unless current_user.nil?
  end


  def read_konfig(key = nil)
    @konfiguration ||= Hash.new
    if key.nil?
        liste = Konfiguration.where("key LIKE ?", "#{params[:controller]}_#{params[:action]}%")
    else
        liste = Konfiguration.where("key LIKE ?", "#{key}%")
    end
    konfiguration ||= Hash.new
    liste.each do |item|
        konfiguration[item.key] = item.value
    end
    @konfiguration = konfiguration.symbolize_keys
  end



  def check_logged_in
    unless user_signed_in?
      redirect_to home_path
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def semaines_at(date)
    if date.nil? || date.blank?
      # Semaines courantes
      date = Date.today
    end
    numero_semaine = "#{date.year}-W#{date.cweek<10 ? '0' : ''}#{date.cweek}"
    @semaines = Semaine.where(numero_semaine: numero_semaine)
  end

  def numeroSemainePourDate(date)
    "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}" 
  end

  def format_numero_semaine(annee, numero_semaine)
    numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
  end

  # Création de logs
  def log(adresse, description = nil)
    date = Time.now
    if user_signed_in?
      utilisateur_id = current_user.id
      nom = current_user.utilisateur.prenom_nom
      unless description.nil?
        description = "[#{nom}] - #{description}"
      else
        description = "[#{nom}]"
      end
    else
      utilisateur_id = nil
    end
    add_in_logdb(date, adresse, utilisateur_id, description)
  end

  private


  def checkCurrentUserIsLogged
    redirect_to home_path unless user_signed_in?
    
  end


  def check_logfile_size(fichier)
    # Check si le fichier ne dépasse pas 1e de lignes
    # Sinon le coupe en deux.
    actions = 50
    lignes_de_log = 5
    limite = actions * lignes_de_log
    file=File.open(fichier,"r")
    lignes = file.readlines
    taille = lignes.size
    file.close
    if taille >= limite
      open(fichier, 'w') { |f|
        lignes[(lignes.size-limite/2)..lignes.size-1].each do |ligne|
          f << "#{ligne}"
        end
      }
    end
  end

  # Ajoute dans un fichier de logs
  def add_in_logfile(date, adresse, utilisateur_id, description)
    fichier = "app/../log/logs.txt"
    if File.exist?(fichier)
      mode = 'a'
      check_logfile_size(fichier)
    else
      mode = 'w'
    end
    open(fichier, mode) { |f|
      f << "DATE            : #{date}\n"
      f << "ADRESSE         : #{adresse}\n"
      f << "UTILISATEUR_ID  : #{utilisateur_id}\n"
      f << "DESCRIPTION     : #{description}\n"
      f << "========================================\n"
    }
  end

  # Ajoute dans la table log de la DB
  def add_in_logdb(date, adresse, utilisateur_id, description)
    limite = 100
    db_size = Log.order(:id).count
    if db_size > limite
      (db_size-limite).times do |i|
        Log.first.delete
      end
    end
    log = Log.new
    log = Log.create(date: date, adresse: adresse, utilisateur_id: utilisateur_id, description: description)
    if log.save
      # ok
    else
      flash[:alert] = I18n.t("logs.index.problem_to_save_logs_in_db")
    end
  end


  def set_page_aide
    #@page_aide = "index" unless @page_aide
  end

  def set_locale
    locale = params[:locale] || cookies[:cookies] || I18n.default_locale
    I18n.locale = locale
    cookies[:locale] = { value: locale, expires: Date.today+3.days }
  end

  def add_log_repport
    controller = params[:controller]
    action = params[:action]

    unless (
      controller == "log_repports" || 
      controller == "logs" ||
      (controller == "devise/sessions" && 
        (
          action == "new" || 
          action == "destroy"
        )
      )
    )
      now = DateTime.now
      month = now.month < 10 ? "0#{now.month}" : "#{now.month}"
      day = now.day < 10 ? "0#{now.day}" : "#{now.day}"
      date = "#{now.year}-#{month}-#{day}"
      hour = now.hour < 10 ? "0#{now.hour}" : "#{now.hour}"
      log_repport = find_lrepport(controller, action, date, hour)
      count = 1
      if log_repport.nil?
        log_repport = LogRepport.new
        #log_repport = LogRepport.create(controller: controller, action: action, count: count, date: date, hour: hour)
        log_repport = LogRepport.create(controller: controller, count: count, date: date, hour: hour)
      else 
        count = log_repport.count + 1
        log_repport.update(count: count)
        if log_repport.save
          # ok
        else
          flash[:alert] = I18n.t("logs.index.problem_to_save_logs_in_db")
        end
      end
    end
  end


  def after_login
    if user_signed_in?
      current_user.last_connection = DateTime.current()
      current_user.save
    end
  end

  

  # Charge les Events
  def charge_events(date, service = nil)
    date = date.to_s
    #events = service.nil? ? Event.where(date: date).order(:service_id, :nom) : Event.where(date: date, service: service).order(:nom)
    events = Event.where(date: date).order(:service_id, :nom)
    events.each do |event|
      @events[event.service_id].nil? && @events[event.service_id] = Array.new
      @events[event.service_id] << event
    end
  end


  # Charge les messages
  def charge_messages(date)
    @messages = Message.where('date_fin >= ? AND date <= ?', date, date).order(:service_id, :date, :date_fin)
end


  # Charge les fermetures
  def charge_fermetures(date, date2)
    @fermetures = Hash.new
    fermetures = Fermeture.where('date_fin >= ? AND date <= ?', date, date2).order(:service_id, :date, :date_fin)
    fermetures.each do |fermeture|
        (fermeture.date..fermeture.date_fin).each do |fj|
            @fermetures[fermeture.service_id] ||= Hash.new
            @fermetures[fermeture.service_id][fj.to_s] = fermeture.nom
        end
    end
  end


  # # # # #  LISTES DE DONNEES A METTRE EN CACHE  # # # # #

  def find_utilisateurs
    log(request.path, "find_utilisateurs")
    if current_user.admin? or is_manager?
      @utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
    else
      @utilisateurs = Utilisateur.where(service: current_user.utilisateur.service).order(:service_id, :groupe_id, :prenom, :nom)
    end
  end

  def find_groupes
    log(request.path, "find_groupes")
    @groupes = Groupe.order(:nom)
  end

  def find_works
    log(request.path, "find_works")
    if current_user.admin?
      @works = Work.order(:service_id, :classe_id, :groupe_id, :nom)
    else
      @works = Work.where(service: current_user.utilisateur.service).order(:service_id, :classe_id, :groupe_id, :nom)
    end
  end

  def find_classes
    log(request.path, "find_classes")
    @classes = Classe.order(:nom)
  end

  
  def find_services
    log(request.path, "find_services")
    @services = Service.order(:nom)
    unless params[:service]
      if user_signed_in?
          @current_service = current_user.utilisateur.service
      else
          @current_service = nil
      end
    else 
        unless params[:service].to_i<0
            @current_service = @services.find_by_id(params[:service])
        else
            @current_service = nil
        end
    end
  end

  def find_lrepport(controller, action, date, hour)
    #log_repport = LogRepport.where("controller = ? AND action = ? AND date = ? AND hour = ?", controller, action, date, hour)
    log_repport = LogRepport.where("controller = ? AND date = ? AND hour = ?", controller, date, hour)
    log_repport = log_repport.length < 1 ? nil : log_repport.first
  end


  #
  # trouve les tâches
  #
  def find_tasks(utilisateur, today = false)
    @tasks = Hash.new
    @tasks_profil = Hash.new
    semaine = (Date.today-3.weeks).cweek
    annee = (Date.today-3.weeks).year


    #hebdos = today ? 
    #  Hebdo.where(numero_semaine: Date.today.cweek, year_id: Date.today.year, utilisateur: utilisateur).order(:numero_semaine) : 
    #  Hebdo.where('numero_semaine > ? AND year_id < ?', semaine, annee ).where(utilisateur: utilisateur).order(:numero_semaine)

    hebdos = today ? 
      Hebdo.where(numero_semaine: Date.today.cweek, year_id: Date.today.year, utilisateur: utilisateur).order(:year_id, :numero_semaine) : 
      Hebdo.where('numero_semaine >= ? AND year_id >= ?', semaine, annee ).where(utilisateur: utilisateur).order(:year_id, :numero_semaine)
    
      #Hebdo.where('numero_semaine > ? AND numero_semaine < ?', from, to ).where(utilisateur: utilisateur).order(:numero_semaine)

    hebdos.each do |hebdo|
        @tasks[hebdo.numero_semaine] ||= Array.new
        @tasks[hebdo.numero_semaine] << [hebdo.task.code, hebdo.task.nom]

        #@tasks_profil[hebdo.year_id] ||= Array.new
        #@tasks_profil[hebdo.year_id][hebdo.numero_semaine] ||= Array.new
        #@tasks_profil[hebdo.year_id][hebdo.numero_semaine] << [hebdo.task.code, hebdo.task.nom]
    end
  end

  def find_tasks_for_month(utilisateur, month, year)
    d = Date.new(year, month, 1)
    semaine_debut = d.cweek
    semaine_fin = (d+10.weeks).cweek
    annee = year

    hebdos = Hebdo.where('numero_semaine >= ? AND numero_semaine <= ? AND year_id >= ?', semaine_debut, semaine_fin, annee ).where(utilisateur: utilisateur).order(:year_id, :numero_semaine)
    return hebdos
  end
end
