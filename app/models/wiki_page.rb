class WikiPage < ApplicationRecord
    
    validates :utilisateur_id, :title, :problem_description, :solution_short, presence: true


end
