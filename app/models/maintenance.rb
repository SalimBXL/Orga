class Maintenance < ApplicationRecord

    before_validation :check_dates
    validates :date_start, :date_end, :name, :contact_id, presence: true

    private

    def check_dates
        self.date_start = Date.today if date_start.nil?
        self.date_end = date_start if date_end.nil?
    end
end
