class Lieu < ApplicationRecord
    has_many :services, dependent: :destroy
    validates_associated :services
    validates :nom, presence: true
    validates :nom, uniqueness: true
end
