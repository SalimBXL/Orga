class Ajout < ApplicationRecord
    validates :utilisateur, :date_lundi, :works, presence: true
    
    
end