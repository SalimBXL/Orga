class Ajout < ApplicationRecord
    validates :utilisateur, :date_lundi, presence: true
    
    def works
        w = Array.new
        unless work1.nil?
            w << work1
        end
        unless work2.nil?
            w << work2
        end
        unless work3.nil?
            w << work3
        end
        unless work4.nil?
            w << work4
        end
        unless work5.nil?
            w << work5
        end
        works = w
    end
    
end