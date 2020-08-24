class WorkingList < ApplicationRecord
    belongs_to :jour
    belongs_to :work

    scope :for, -> (jour_id) { where(jour_id: jour_id) }
    
end
