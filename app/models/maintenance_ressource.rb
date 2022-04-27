class MaintenanceRessource < ApplicationRecord
  belongs_to :service
  has_many :maintenances
  validates :name, presence: true
end
