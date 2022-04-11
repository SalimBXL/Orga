class LogRepport < ApplicationRecord
    validates :date, :hour, :controller, :count, presence: true

end
