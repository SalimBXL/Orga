class Semaine < ApplicationRecord
    belongs_to :utilisateur
    has_many :jobs
    validates_associated :jobs
    validates :numero_semaine, :date_lundi, presence: true
    validates :numero_semaine, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 53 }
end
