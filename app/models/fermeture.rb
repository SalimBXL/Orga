class Fermeture < ApplicationRecord
    belongs_to :service
    before_validation :set_date_fin
    validates :nom, :date, :date_fin, presence: true

    scope :at, -> (d) { where('date_fin >= ? AND date <= ?', d, d) }
    scope :at_for_service, -> (d,u) { self.at(d).where(service_id: u) }
    scope :at_for_service?, -> (d,u) { self.at_for_service(d, u).count>0 }

    after_find do |fermeture|
        if fermeture.date_fin.nil?
            fermeture.date_fin = fermeture.date
        end
    end


    private

    def set_date_fin
        if date_fin.nil? || date_fin.blank?
            self.date_fin = date
        end
        if date_fin<date
            self.date_fin = date
        end
    end

end
