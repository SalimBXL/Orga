FactoryBot.define do
  factory :job do
    numero_jour { rand(1..5) }
    am_pm { Faker::Boolean.boolean }
    note { Faker::Lorem.sentence }
    semaine
  end
end
