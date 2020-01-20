class Service < ApplicationRecord
    has_many :utilisateurs
    validates_associated :utilisateurs
    validates :nom, presence: true
end
