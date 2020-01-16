class Utilisateur < ApplicationRecord
    belongs_to :groupe
    belongs_to :service
    has_many :semaines
    
end
