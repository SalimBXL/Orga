FactoryBot.define do
  jour = Faker::Date.in_date_period
  lundi =  jour - jour.cwday + 1
  factory :semaine do
    date_lundi { lundi }
    numero_semaine { lundi.cweek }
    note { Faker::Lorem.sentence }
    utilisateur
  end
end
