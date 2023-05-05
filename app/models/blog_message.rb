class BlogMessage < ApplicationRecord
    belongs_to :blog_category
    belongs_to :utilisateur
    #belongs_to :reviewcat

    has_rich_text :content
    
    
    validates :date, :title, :description, :utilisateur_id, presence: true

    def ref_article
        self.created_at.strftime("%Y%m%d%H%M%S").to_s
    end

end
