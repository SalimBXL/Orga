class Job < ApplicationRecord
    before_validation :set_service
    belongs_to :semaine
    belongs_to :service
    has_many :working_lists, dependent: :destroy
    validates_associated :working_lists
    validates :numero_jour, :service_id, presence: true
    validates :numero_jour, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    after_find :update_service

    def update_service
        if service_id.nil?
            self.service_id = Service.first.id
        end
    end

    def set_service
        if !service_id.present?
            self.service_id = Service.first.id
        end
    end


    def numero_semaine
        semaine.numero_semaine
    end
    

    def works_code
        w = Array.new
        working_lists.each do |work|
            w << work.work.code
        end
        works_code = w
    end

    def works_nom
        w = Array.new
        working_lists.each do |work|
            w << work.work.nom
        end
        works_code = w
    end

    def works
        w = Array.new
        working_lists.each do |work|
            w << "(#{work.work.code}) - #{work.work.nom}"
        end
        works_code = w
    end

    
end
