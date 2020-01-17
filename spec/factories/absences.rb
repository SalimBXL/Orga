FactoryBot.define do
  factory :absence do
    date { Faker::Date.between(from: 30.days.ago, to: 90.days.from.now) }
    remarque { Faker::Boolean.boolean }
  end
end
