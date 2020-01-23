class Absence < ApplicationRecord
    belongs_to :type_absence
    belongs_to :utilisateur
    validates :date, presence: true
    
    
end
