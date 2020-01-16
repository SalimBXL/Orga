class Job < ApplicationRecord
    belongs_to :semaine
    has_many :working_lists
    
end
