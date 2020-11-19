class BlogMessage < ApplicationRecord
    belongs_to :blog_category
    belongs_to :utilisateur
    validates :date, :title, :description, presence: true

end
