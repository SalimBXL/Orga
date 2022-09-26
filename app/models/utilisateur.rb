class Utilisateur < ApplicationRecord
    belongs_to :groupe
    belongs_to :service
    belongs_to :user
    has_many :messages, dependent: :destroy
    has_many :jours, dependent: :destroy
    has_many :absences, dependent: :destroy
    has_many :demande_conges, dependent: :destroy
    has_many :hebdos, dependent: :destroy
    has_many :postits, dependent: :destroy
    has_many :maintenance
    validates_associated :absences
    validates_associated :jours
    validates :nom, :prenom, :email, presence: true
    validates :email, uniqueness: true

    def last_action
        self.user.last_connection unless self.user.nil?
    end
    
    def prenom_nom
        "#{prenom} #{nom}".titleize
    end

    def initiales
        "#{prenom[0]}#{nom[0]}".upcase
    end

    def profil
        if user.nil?
            self.user = User.find_by(email: email.downcase)
        end
        user
    end

    def conge?(date)
        abs = Absence.where(utilisateur_id: self.id).where('date >= ? OR date_fin <= ?', date, date).first
        if abs.nil?
            abs
        else 
            abs.accord
        end
    end
    
end
