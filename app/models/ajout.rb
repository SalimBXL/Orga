class Ajout < ApplicationRecord
    validates :utilisateur, :date_lundi, presence: true
    
    def set_works_to_array
        works = Array.new
        unless work1.nil?
            works << work1
        end
        unless work2.nil?
            works << work2
        end
        unless work3.nil?
            works << work3
        end
        unless work4.nil?
            works << work4
        end
        unless work5.nil?
            works << work5
        end
    end
    
end