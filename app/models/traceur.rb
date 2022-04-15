class Traceur < ApplicationRecord
    validates :code, presence: true
    validates :code, uniqueness: true
    has_many :production, dependent: :destroy
end
