class Jour < ApplicationRecord
    before_validation :set_set_numero_semaine
    validates :numero_semaine, :date, presence: true
    validates_associated :working_lists
    validates :service_id, presence: true
    belongs_to :utilisateur
    has_many :working_lists, dependent: :destroy
    

    def set_numero_semaine
        "#{date_lundi.year}-W#{date_lundi.cweek<10 ? "0" : ""}#{date_lundi.cweek}" 
    end
    
    private

    def set_set_numero_semaine
        self.numero_semaine = "#{date_lundi.year}-W#{date_lundi.cweek<10 ? "0" : ""}#{date_lundi.cweek}" 
    end

    
end
