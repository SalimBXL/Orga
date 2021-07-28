class Hebdo < ApplicationRecord
    belongs_to :utilisateur
    belongs_to :task
    validates :numero_semaine, presence: true
    
    

    def set_numero_semaine(date)
        self.numero_semaine = "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}"
    end

end
