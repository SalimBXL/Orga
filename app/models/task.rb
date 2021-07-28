class Task < ApplicationRecord
    belongs_to :groupe
    belongs_to :classe
    belongs_to :service
    has_many :hebdos, dependent: :destroy
    validates :nom, :code, presence: true
    validates :code, uniqueness: true
    
end
