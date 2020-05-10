# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



#
# LIEUX
#
Lieu.create(
    nom: "Erasme",
    adresse: "Route de Lennik 808, 1070 Bruxelles",
    phone: "+325554711"
)
Lieu.create(
    nom: "UZ"
)


#
# SERVICES
#
Service.create(
    lieu: Lieu.all.first,
    nom: "Cyclotron"
)
Service.create(
    lieu: Lieu.all.first,
    nom: "Isotopes"
)
Service.create(
    lieu: Lieu.all.last,
    nom: "Cyclo UZ"
)


#
# GROUPES
#
Groupe.create(
    nom: "Operateur"
)
Groupe.create(
    nom: "Responsable"
)
Groupe.create(
    nom: "Student"
)
Groupe.create(
    nom: "Divers"
)
Groupe.create(
    nom: "I.T."
)


#
# UTILISATEURS
#
Utilisateur.create(
    prenom: "John",
    nom: "Van Naemen",
    email: "john.vannaemen@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Simon",
    nom: "Lacroix",
    email: "simon.lacroix@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Michel",
    nom: "Monclus",
    email: "michel.monclus@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Etienne",
    nom: "Luciani",
    email: "etienne.luciani@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Kévin",
    nom: "Thibaut",
    email: "kevin.thibaut@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Khalid",
    nom: "Milloudi",
    email: "khalid.milloudi@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Salim",
    nom: "Joly",
    email: "anthony.joly@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "I.T.").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Nicola",
    nom: "Trotta",
    email: "nicola.trotta@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "I.T.").first,
    service: Service.where(nom: "Cyclotron").first
)
Utilisateur.create(
    prenom: "Eric",
    nom: "Mulleneers",
    email: "eric.mulleneers@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)


#
# TYPE ABSENCES
#
TypeAbsence.create(
    code: "Ma",
    nom: "Certificat médical",
)

TypeAbsence.create(
    code: "Co",
    nom: "Congé",
)


#
# WORKS
#
Work.create(
    nom: "FDG 5h",
    code: "5",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Work.create(
    nom: "Contrôle qualité",
    code: "QC",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Work.create(
    nom: "Livraison",
    code: "L",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
Work.create(
    nom: "Methionine",
    code: "M",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first
)
