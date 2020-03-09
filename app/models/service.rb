class Service < ApplicationRecord
    belongs_to :lieu
    has_many :utilisateurs
    has_many :works, dependent: :destroy
    validates_associated :utilisateurs
    validates :nom, presence: true
end
