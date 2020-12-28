class Konfiguration < ApplicationRecord
    validates :value, :key, presence: true
    validates :key, uniqueness: true
end
