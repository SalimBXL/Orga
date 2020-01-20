class TypeAbsence < ApplicationRecord
    has_many :absences
    validates_associated :absences
    validates :nom, presence: true
end
