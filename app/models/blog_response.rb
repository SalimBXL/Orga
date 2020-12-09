class BlogResponse < ApplicationRecord
    belongs_to :blog_message
    belongs_to :utilisateur
    validates :description, presence: true

end
