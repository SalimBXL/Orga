class Groupe < ApplicationRecord
    has_many :utilisateurs
    has_many :works
    validates_associated :utilisateurs
    validates_associated :works
    validates :nom, presence: true
end
