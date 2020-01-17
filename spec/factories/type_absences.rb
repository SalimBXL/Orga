FactoryBot.define do
  factory :type_absence do
    nom { Faker::Verb.ing_form }
    description { Faker::Lorem.sentence }
  end
end
