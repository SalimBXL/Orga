class Lieu < ApplicationRecord
    has_many :services
    validates_associated :services
    validates :nom, presence: true
end
