class Maintenance < ApplicationRecord
    belongs_to :maintenance_ressource
    before_validation :check_dates
    validates :date_start, :date_end, :contact_id, presence: true

    def isToday?
        (date_start <= Date.today and date_end >= Date.today)
    end

    def isWithinFiveDays?
        (Date.today >= date_start-5.days)
    end

    def isWithinTwoWeeks?
        (Date.today >= date_start-15.days)
    end

    def isLaterThanTwoWeeks?
        (Date.today < date_start-15.days)
    end


    def isPassed?
        (date_end < Date.today)
    end


    private

    def check_dates
        self.date_start = Date.today if date_start.nil?
        self.date_end = date_start if date_end.nil?
    end
end
