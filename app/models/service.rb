class Service < ApplicationRecord
    belongs_to :lieu
    has_many :utilisateurs
    has_many :messages, dependent: :destroy
    has_many :fermeture, dependent: :destroy
    has_many :works, dependent: :destroy
    has_many :jours, dependent: :destroy
    has_many :maintenance_ressources, dependent: :destroy
    has_many :lien_utilisateur_services
    has_many :postits, dependent: :destroy
    validates_associated :utilisateurs
    validates :nom, presence: true
    validates :nom, uniqueness: true

    def closed?(date)
        !Fermeture.where(service_id: self.id).where('date >= ? AND date_fin <= ?', date, date).first.nil?
    end

    def utilisateurs
        utilisateurs = LienUtilisateurService.where(utilisateur_id: self.id)
        utilisateurs = nil if utilisateurs.length < 1
    end
end
