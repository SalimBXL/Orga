class Utilisateur < ApplicationRecord
    belongs_to :groupe
    belongs_to :service
    has_many :semaines, dependent: :destroy
    has_many :conges, dependent: :destroy
    has_many :absences, dependent: :destroy
    validates_associated :absences
    validates_associated :semaines
    validates_associated :conges
    validates :nom, :prenom, :email, presence: true
    validates :email, uniqueness: true

    def prenom_nom
        "#{prenom} #{nom}".titleize
    end
end
