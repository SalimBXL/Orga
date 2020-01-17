FactoryBot.define do
  factory :conge do
    date { Faker::Date.between(from: 30.days.ago, to: 90.days.from.now) }
    accord { false }
    remarque { Faker::Boolean.boolean }
  end
end
