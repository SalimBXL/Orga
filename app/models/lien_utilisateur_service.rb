class LienUtilisateurService < ApplicationRecord
    belongs_to :utilisateur
    belongs_to :service

    scope :forService, -> (service) { where(service: service) }
    scope :forUtilisateur, -> (utilisateur) { where(utilisateur: utilisateur) }
    
end
