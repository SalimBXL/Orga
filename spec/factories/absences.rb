FactoryBot.define do
  factory :absence do
    date { Faker::Date.in_date_period }
    remarque { Faker::Lorem.sentence }
  end
end
