class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

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

  def format_numero_semaine(annee, numero_semaine)
    numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
  end

  private

  def set_locale
    locale = params[:locale] || cookies[:cookies] || I18n.default_locale
    I18n.locale = locale
    cookies[:locale] = { value: locale, expires:30.days }
  end

end
