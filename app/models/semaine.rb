class Semaine < ApplicationRecord
    belongs_to :utilisateur
    has_many :jobs
    
end
