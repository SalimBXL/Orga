class Event < ApplicationRecord
    belongs_to :service
    validates :nom, :date, presence: true

    scope :at, -> (d) { where(date: d) }

end
