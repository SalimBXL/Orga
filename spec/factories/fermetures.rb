FactoryBot.define do
  factory :fermeture do
    nom { "Nom fermeture" }
    date { Date.today }
    date_fin { Date.today + 5.days }
    note { "Une note" }
    service
  end
end
