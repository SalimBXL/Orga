FactoryBot.define do
  factory :conge do
    date { Faker::Date.in_date_period }
    accord { Faker::Boolean.boolean }
    remarque { Faker::Lorem.sentence }
  end
end
