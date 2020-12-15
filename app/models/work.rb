class Work < ApplicationRecord
    belongs_to :groupe
    belongs_to :classe
    belongs_to :service
    has_many :working_lists, dependent: :destroy
    validates_associated :working_lists
    validates :nom, :code, presence: true
    validates :code, uniqueness: true
    before_validation :set_early_value

    private

    def set_early_value
        self.early_value = 2 unless early_value
    end
end
