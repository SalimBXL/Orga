class Hebdo < ApplicationRecord
    belongs_to :utilisateur
    belongs_to :task
    validates :numero_semaine, presence: true
    before_validation :set_year_if_empty
    

    def set_numero_semaine(date)
        self.numero_semaine = "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}"
    end

    private

    def set_year_if_empty
        self.year_id = "#{Date.today.year}" if year_id.nil?
    end

end