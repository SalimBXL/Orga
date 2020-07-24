class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  #after_action :after_login

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
    #add_in_logfile(date, adresse, utilisateur_id, description)
    add_in_logdb(date, adresse, utilisateur_id, description)
  end

  private

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
    db_size = Log.all.count
    if db_size > 50

    end
    log = Log.new
    log = Log.create(date: date, adresse: adresse, utilisateur_id: utilisateur_id, description: description)
    if log.save
      # ok
    else
      flash[:alert] = I18n.t("logs.index.problem_to_save_logs_in_db")
    end
  end




  def set_locale
    locale = params[:locale] || cookies[:cookies] || I18n.default_locale
    I18n.locale = locale
    cookies[:locale] = { value: locale, expires: Date.today+3.days }
  end

  def after_login
    if user_signed_in?
      current_user.last_connection = DateTime.current()
      current_user.save
    end
  end

end
