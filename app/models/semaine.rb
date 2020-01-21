class Semaine < ApplicationRecord
    belongs_to :utilisateur
    has_many :jobs
    validates_associated :jobs
    validates :numero_semaine, :date_lundi, presence: true
end
