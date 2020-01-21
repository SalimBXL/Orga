class Work < ApplicationRecord
    belongs_to :groupe
    has_many :working_lists
    validates_associated :working_lists
    validates :nom, presence: true
end
