FactoryBot.define do
    factory :absence do
      date { Date.today }
      date_fin { Date.today + 5.days }
      type_absence
      utilisateur
    end
  end
  