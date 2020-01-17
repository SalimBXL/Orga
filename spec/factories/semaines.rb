FactoryBot.define do
  factory :semaine do
    numero_semaine { 1 }
    date_lundi { Faker::Date.forward(days: 23) }
    note { Faker::Lorem.sentence }
  end
end
