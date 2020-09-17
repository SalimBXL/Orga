class Template < ApplicationRecord
    validates :nom, :service_id, presence: true
    before_save :check_works


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