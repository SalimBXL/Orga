class Fermeture < ApplicationRecord
    belongs_to :service
    before_validation :set_date_fin
    validates :nom, :date, presence: true


    after_find do |fermeture|
        if fermeture.date_fin.nil?
            fermeture.date_fin = fermeture.date
        end
    end


    private

    def set_date_fin
        if date_fin.nil?
            self.date_fin = date
        end
    end

end
