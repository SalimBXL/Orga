class BugRepport < ApplicationRecord
    belongs_to :utilisateur
    validates :date, :nom, :description, presence: true
    
end
