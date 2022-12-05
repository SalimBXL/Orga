class Postit < ApplicationRecord

    belongs_to :utilisateur
    belongs_to :service
    belongs_to :taken, class_name: "Utilisateur", optional: true
    before_validation :check_level
    
    
    validates :body, presence: true

    def level_color
        if (level == 4)
            "danger"
        elsif (level == 3)
            "warning"
        elsif (level == 2)
            "info"
        else 
            ""
        end
    end

    def check_level
        self.level = 2 if !taken.nil?
        self.level = 1 if (level == 2 && taken.nil?)
        self.level = 1 if (level.nil? || level == "")
        self.level = 0 if !done_at.nil?
    end
end
