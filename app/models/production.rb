class Production < ApplicationRecord
  belongs_to :traceur
  belongs_to :prod_unit
  belongs_to :prod_destination
  belongs_to :service
  belongs_to :utilisateur
end
