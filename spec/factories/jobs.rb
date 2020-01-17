FactoryBot.define do
  factory :job do
    numero_jour { 1 }
    am_pm { false }
    note { Faker::Lorem.sentence }
  end
end
