class Template < ApplicationRecord
    validates :nom, :service_id, presence: true
    before_save :check_works


    # date utilisateur_id work1 work2 work3 work4 work5 
    def create_array_from_template(utilisateur_id)
        liste = Hash.new
        ligne = Hash.new

        ligne["utilisateur_id"] = utilisateur_id
        ligne["work1"] = work1_1
        ligne["work2"] = work1_2
        ligne["work3"] = work1_3
        ligne["work4"] = work1_4
        ligne["work5"] = work1_5
        liste[0] = ligne
        ligne = Hash.new

        ligne["utilisateur_id"] = utilisateur_id
        ligne["work1"] = work2_1
        ligne["work2"] = work2_2
        ligne["work3"] = work2_3
        ligne["work4"] = work2_4
        ligne["work5"] = work2_5
        liste[1] = ligne
        ligne = Hash.new

        ligne["utilisateur_id"] = utilisateur_id
        ligne["work1"] = work3_1
        ligne["work2"] = work3_2
        ligne["work3"] = work3_3
        ligne["work4"] = work3_4
        ligne["work5"] = work3_5
        liste[2] = ligne
        ligne = Hash.new

        ligne["utilisateur_id"] = utilisateur_id
        ligne["work1"] = work4_1
        ligne["work2"] = work4_2
        ligne["work3"] = work4_3
        ligne["work4"] = work4_4
        ligne["work5"] = work4_5
        liste[3] = ligne
        ligne = Hash.new

        ligne["utilisateur_id"] = utilisateur_id
        ligne["work1"] = work5_1
        ligne["work2"] = work5_2
        ligne["work3"] = work5_3
        ligne["work4"] = work5_4
        ligne["work5"] = work5_5
        liste[4] = ligne
        ligne = Hash.new
        
        create_array_from_template = liste
    end



    private

    def check_works
        # Day 1
        self.work1_1 = nil if work1_1.nil? and Work.find_by_id(work1_1).nil?
        self.work1_2 = nil if work1_2.nil? and Work.find_by_id(work1_2).nil?
        self.work1_3 = nil if work1_3.nil? and Work.find_by_id(work1_3).nil?
        self.work1_4 = nil if work1_4.nil? and Work.find_by_id(work1_4).nil?
        self.work1_5 = nil if work1_5.nil? and Work.find_by_id(work1_5).nil?
        # Day 2
        self.work2_1 = nil if work2_1.nil? and Work.find_by_id(work2_1).nil?
        self.work2_2 = nil if work2_2.nil? and Work.find_by_id(work2_2).nil?
        self.work2_3 = nil if work2_3.nil? and Work.find_by_id(work2_3).nil?
        self.work2_4 = nil if work2_4.nil? and Work.find_by_id(work2_4).nil?
        self.work2_5 = nil if work2_5.nil? and Work.find_by_id(work2_5).nil?
        # Day 3
        self.work3_1 = nil if work3_1.nil? and Work.find_by_id(work3_1).nil?
        self.work3_2 = nil if work3_2.nil? and Work.find_by_id(work3_2).nil?
        self.work3_3 = nil if work3_3.nil? and Work.find_by_id(work3_3).nil?
        self.work3_4 = nil if work3_4.nil? and Work.find_by_id(work3_4).nil?
        self.work3_5 = nil if work3_5.nil? and Work.find_by_id(work3_5).nil?
        # Day 4
        self.work4_1 = nil if work4_1.nil? and Work.find_by_id(work4_1).nil?
        self.work4_2 = nil if work4_2.nil? and Work.find_by_id(work4_2).nil?
        self.work4_3 = nil if work4_3.nil? and Work.find_by_id(work4_3).nil?
        self.work4_4 = nil if work4_4.nil? and Work.find_by_id(work4_4).nil?
        self.work4_5 = nil if work4_5.nil? and Work.find_by_id(work4_5).nil?
        # Day 5
        self.work5_1 = nil if work5_1.nil? and Work.find_by_id(work5_1).nil?
        self.work5_2 = nil if work5_2.nil? and Work.find_by_id(work5_2).nil?
        self.work5_3 = nil if work5_3.nil? and Work.find_by_id(work5_3).nil?
        self.work5_4 = nil if work5_4.nil? and Work.find_by_id(work5_4).nil?
        self.work5_5 = nil if work5_5.nil? and Work.find_by_id(work5_5).nil?
    end

    def set_am_pms
        self.am_pm1 = am_pm1.to_s.downcase == 'true' ? true : false
        self.am_pm2 = am_pm2.to_s.downcase == 'true' ? true : false
        self.am_pm3 = am_pm3.to_s.downcase == 'true' ? true : false
        self.am_pm4 = am_pm4.to_s.downcase == 'true' ? true : false
        self.am_pm5 = am_pm5.to_s.downcase == 'true' ? true : false
    end
    
end