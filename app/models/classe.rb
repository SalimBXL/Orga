class Classe < ApplicationRecord
    has_many :works, dependent: :destroy
    validates_associated :works
    validates :nom, presence: true
    validates :nom, uniqueness: true
end
