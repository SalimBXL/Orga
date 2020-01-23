class Work < ApplicationRecord
    validates :nom, :code, presence: true
    belongs_to :groupe
    has_many :working_lists, dependent: :destroy
    validates_associated :working_lists
    
end
