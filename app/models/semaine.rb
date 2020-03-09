class Semaine < ApplicationRecord
    before_validation :set_slug, if: :should_set_slug?
    before_validation :set_numero_semaine, if: :should_set_numero_semaine?
    validates :numero_semaine, :date_lundi, presence: true
    validates :slug, uniqueness: true
    belongs_to :utilisateur
    has_many :jobs, dependent: :destroy
    validates_associated :jobs

    def set_numero_semaine
        "#{date_lundi.year}-W#{date_lundi.cweek<10 ? "0" : ""}#{date_lundi.cweek}" 
    end
    
    private

    def should_set_numero_semaine?
        !numero_semaine.present? || date_lundi.year!=numero_semaine[0..3] || numero_semaine[4]!="W"
    end

    def should_set_slug?
        numero_semaine.present? && utilisateur_id.present?
    end

    def set_slug        
        self.slug = "#{"#{utilisateur.prenom} #{utilisateur.nom}".titleize} #{numero_semaine}".parameterize
    end
end
