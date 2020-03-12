class Ajout < ApplicationRecord
    validates :utilisateur, :date_lundi, presence: true
    before_validation :set_numero_jour
    before_validation :set_date_lundi
    before_validation :set_am_pm
    

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

    private

    def set_am_pm
        if am_pm.nil? || (am_pm!=false && am_pm!=true)
            self.am_pm = false
        else 
            self.am_pm = am_pm.to_s.downcase == 'true' ? true : false
        end
    end

    def set_date_lundi
        self.date_lundi = date_lundi.beginning_of_week
    end

    def set_numero_jour
        if numero_jour.nil? || numero_jour<1 || numero_jour>7
            self.numero_jour = date_lundi.cwday
        end
    end
    
end