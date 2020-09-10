class Message < ApplicationRecord
    belongs_to :service
    #belongs_to :utilisateur
    validates :date, :note, presence: true
    before_validation :set_dates

    private


    def set_dates
        if date.nil? || date.blank?
            self.date = Date.today
        end
        if date_fin.nil? || date_fin.blank? || date_fin < date
            self.date_fin = date
        end
    end

end
