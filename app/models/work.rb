class Work < ApplicationRecord
    belongs_to :groupe
    belongs_to :classe
    belongs_to :service
    has_many :working_lists, dependent: :destroy
    validates_associated :working_lists
    validates :nom, :code, presence: true
    validates :code, uniqueness: true
end
