class LogRepport < ApplicationRecord
    validates :controller, :action, :count, presence: true

end
