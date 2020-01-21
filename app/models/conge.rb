class Conge < ApplicationRecord
    belongs_to :utilisateur
    validates :date, presence: true
    
end
