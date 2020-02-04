class Semaine < ApplicationRecord
    before_validation :set_slug, if: :should_set_slug?
    validates :numero_semaine, :date_lundi, presence: true
    validates :slug, uniqueness: true
    belongs_to :utilisateur
    has_many :jobs, dependent: :destroy
    validates_associated :jobs
    
    private

    def should_set_slug?
        numero_semaine.present? && utilisateur_id.present?
    end

    def set_slug        
        self.slug = "#{"#{utilisateur.prenom} #{utilisateur.nom}".titleize} #{numero_semaine}".parameterize
    end
end
