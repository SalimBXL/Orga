class TypeAbsence < ApplicationRecord
    has_many :absences, dependent: :destroy
    validates_associated :absences
    validates :nom, presence: true
end
