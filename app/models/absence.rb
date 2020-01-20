class Absence < ApplicationRecord
    belongs_to :type_absence
    validates :date, presence: true
    
    
end
