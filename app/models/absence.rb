class Absence < ApplicationRecord
    belongs_to :type_absence
    belongs_to :utilisateur
    before_validation :check_date_fin
    validates :date, presence: true

    scope :at, -> (d) { where("date <= ? AND date_fin >= ?", d, d) }
    scope :today, -> { self.at(Date.today) }
    scope :at_for_user, -> (d,u) { self.at(d).where(utilisateur: u) }
    scope :today_for_user, -> (u) { self.at_for_user(Date.today, u) }

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
