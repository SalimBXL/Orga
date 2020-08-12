class Ajout < ApplicationRecord
    belongs_to :utilisateur
    validates :date, :work1, presence: true
    after_validation :set_am_pm
    before_validation :set_date
    before_create :set_date
    before_save :check_work

    def service
        w = Work.find_by_id(work1)
        w.service.nom unless w.nil?
    end

    def check_services
        s = Array.new
        wks = self.works
        wks.each do |wk|
            w = Work.find_by_id(wk)
            unless w.nil?
                s << w.service.nom unless s.include?(w.service.nom)
            end
        end
        if s.count > 1
            s
        else
            nil
        end
    end

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

    def check_work
        if (!work1.nil?)
            self.work1 = nil if Work.find_by_id(work1).nil?
        end
        if (!work2.nil?)
            self.work2 = nil if Work.find_by_id(work2).nil?
        end
        if (!work3.nil?)
            self.work3 = nil if Work.find_by_id(work3).nil?
        end
        if (!work4.nil?)
            self.work4 = nil if Work.find_by_id(work4).nil?
        end
        if (!work5.nil?)
            self.work5 = nil if Work.find_by_id(work5).nil?
        end
    end

    def set_am_pm
        if am_pm.nil? || (am_pm!=false && am_pm!=true)
            self.am_pm = false
        else 
            self.am_pm = am_pm.to_s.downcase == 'true' ? true : false
        end
    end

    def set_date
        if date.nil? || date.blank?
            self.date = Date.today
        end
    end
    
end