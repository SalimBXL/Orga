class Absence < ApplicationRecord
    belongs_to :type_absence
    belongs_to :utilisateur
    before_validation :check_date_fin
    validates :date, presence: true

    def check_date_fin
        if date
            if date_fin.nil? || date_fin.blank? 
                self.date_fin = date
            end
            if date_fin<date
                self.date_fin = date
            end
        end
    end
    
end
