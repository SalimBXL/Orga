FactoryBot.define do
    factory :jour do
        date { Date.today }
        utilisateur
        service
    end
  end
  