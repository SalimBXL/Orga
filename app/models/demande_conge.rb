class DemandeConge < ApplicationRecord
    belongs_to :utilisateur
    before_validation :set_date_fin
    validates :date, :date_fin, :date_demande, presence: true

    scope :for_user, -> (u) { where(utilisateur: u) }

    after_find do |demande|
        if demande.date_fin.nil?
            demande.date_fin = demande.date
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
