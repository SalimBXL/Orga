class Work < ApplicationRecord
    belongs_to :lieu
    has_many :working_lists
    validates_associated :working_lists
    validates :nom, presence: true
end
