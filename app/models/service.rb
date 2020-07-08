class Service < ApplicationRecord
    belongs_to :lieu
    has_many :utilisateurs
    has_many :fermeture, dependent: :destroy
    has_many :works, dependent: :destroy
    has_many :jours, dependent: :destroy
    validates_associated :utilisateurs
    validates :nom, presence: true
    validates :nom, uniqueness: true

    def closed?(date)
        !Fermeture.where(service_id: self.id).where('date >= ? AND date_fin <= ?', date, date).first.nil?
    end
end
