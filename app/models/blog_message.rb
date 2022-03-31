class BlogMessage < ApplicationRecord
    belongs_to :blog_category
    belongs_to :utilisateur
    belongs_to :reviewcat
    validates :date, :title, :description, :utilisateur_id, presence: true

end
