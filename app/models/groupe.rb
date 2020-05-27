class Groupe < ApplicationRecord
    has_many :utilisateurs, dependent: :destroy
    has_many :works
    validates_associated :utilisateurs
    validates_associated :works
    validates :nom, presence: true
    validates :nom, uniqueness: true
end
