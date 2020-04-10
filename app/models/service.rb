class Service < ApplicationRecord
    belongs_to :lieu
    has_many :utilisateurs
    has_many :jobs
    has_many :fermeture, dependent: :destroy
    has_many :works, dependent: :destroy
    validates_associated :utilisateurs
    validates :nom, presence: true
end
