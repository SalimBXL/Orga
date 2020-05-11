class Utilisateur < ApplicationRecord
    belongs_to :groupe
    belongs_to :service
    has_many :jours, dependent: :destroy
    has_many :absences, dependent: :destroy
    validates_associated :absences
    validates_associated :jours
    validates :nom, :prenom, :email, presence: true
    validates :email, uniqueness: true

    def prenom_nom
        "#{prenom} #{nom}".titleize
    end

    def initiales
        "#{prenom[0]}#{nom[0]}".upcase
    end
end
