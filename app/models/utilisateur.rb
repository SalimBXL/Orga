class Utilisateur < ApplicationRecord
    belongs_to :groupe
    belongs_to :service
    has_many :semaines
    validates_associated :semaines
    validates :nom, :prenom, :email, presence: true
    validates :email, uniqueness: true
    validates :email, confirmation: { case_sensitive: false }
    validates :email, confirmation: true
    validates :email_confirmation, presence: true

    
end
