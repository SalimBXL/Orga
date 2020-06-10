class Jour < ApplicationRecord
    belongs_to :utilisateur
    belongs_to :service
    has_many :working_lists, dependent: :destroy
    before_validation :set_am_pm
    before_validation :set_numero_semaine
    before_validation :set_numero_jour
    validates :date, presence: true
    validates_associated :working_lists
    
    scope :today, -> { where(date: Date.today).order(:service_id, :utilisateur_id, :am_pm) }
    scope :at_day, -> (atday) { where(date: atday).order(:service_id, :utilisateur_id, :am_pm) }
    scope :of, -> (user_id) { where(utilisateur_id: user_id) }

    def numero_semaine
        "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}"
    end

    def numero_jour
        date.cwday
    end

    
    
    private

    def set_numero_semaine
        if date.nil?
            nil
        else
            "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}"
        end
    end

    def set_numero_jour
        if date.nil?
            nil
        else
            self.numero_jour = date.cwday
        end
    end

    def set_am_pm
        if (am_pm.nil? || !am_pm.present? || am_pm.blank?)
            self.am_pm = 0
        end
    end

    
end
