class Reviewcat < ApplicationRecord

    validates :cat, presence: true
    has_many :postits

end
