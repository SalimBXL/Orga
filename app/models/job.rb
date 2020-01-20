class Job < ApplicationRecord
    belongs_to :semaine
    has_many :working_lists
    validates_associated :working_lists
    validates :numero_jour, presence: true
    validates :numero_jour, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
