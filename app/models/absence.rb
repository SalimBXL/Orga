class Absence < ApplicationRecord
    belongs_to :type_absence
    belongs_to :utilisateur
    before_validation :check_date_fin

    validates :date, presence: true

    private

    def check_date_fin
        if date_fin.nil?
            self.date_fin = date
        else
            if date_fin < date
                self.date_fin = date
            end
        end
    end
    
    
end
