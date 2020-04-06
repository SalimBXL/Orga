class Conge < ApplicationRecord
    belongs_to :utilisateur
    before_validation :set_date_fin
    validates :date, presence: true


    after_find do |conge|
        if conge.date_fin.nil?
            conge.date_fin = conge.date
        end
    end

    private

    def set_date_fin
        if date_fin.nil?
            self.date_fin = date
        end
    end
    
end
