FactoryBot.define do
  factory :absence do
    type_absence_id { 1 }
    date { Faker::Date.in_date_period }
    remarque { Faker::Lorem.sentence }
  end
end
