class Service < ApplicationRecord
    belongs_to :lieu
    has_many :utilisateurs
    validates_associated :utilisateurs
    validates :nom, presence: true
end
