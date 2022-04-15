class ProdUnit < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    has_many :production, dependent: :destroy
end
