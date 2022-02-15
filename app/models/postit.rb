class Postit < ApplicationRecord

    belongs_to :utilisateur
    belongs_to :taken, class_name: "Utilisateur"
    
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

end
