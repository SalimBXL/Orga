class Lieu < ApplicationRecord
    has_many :works
    validates_associated :works
    validates :nom, presence: true
end
