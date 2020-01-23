FactoryBot.define do
  jour = Faker::Date.in_date_period
  lundi =  jour - jour.cwday + 1
  num = "#{lundi.year}-W#{lundi.cweek<10 ? '0' : ''}#{lundi.cweek}"
  #slug = "#{Faker::Name.first_name} #{Faker::Name.last_name} #{num}".parameterize
  factory :semaine do
    date_lundi { lundi }
    numero_semaine { num }
    slug { nil }
    note { Faker::Lorem.sentence }
    utilisateur
  end
end
