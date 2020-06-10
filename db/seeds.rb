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
User.create(
    email: "john.vannaemen@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "John",
    nom: "Van Naemen",
    email: "john.vannaemen@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "john.vannaemen@erasme.ulb.ac.be").first,
    admin: true
)

User.create(
    email: "simon.lacroix@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Simon",
    nom: "Lacroix",
    email: "simon.lacroix@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "simon.lacroix@erasme.ulb.ac.be").first
)

User.create(
    email: "michel.monclus@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Michel",
    nom: "Monclus",
    email: "michel.monclus@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Responsable").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "michel.monclus@erasme.ulb.ac.be").first
)

User.create(
    email: "etienne.luciani@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Etienne",
    nom: "Luciani",
    email: "etienne.luciani@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "etienne.luciani@erasme.ulb.ac.be").first
)

User.create(
    email: "kevin.thibaut@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Kévin",
    nom: "Thibaut",
    email: "kevin.thibaut@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "kevin.thibaut@erasme.ulb.ac.be").first
)

User.create(
    email: "khalid.milloudi@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Khalid",
    nom: "Milloudi",
    email: "khalid.milloudi@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "khalid.milloudi@erasme.ulb.ac.be").first
)

User.create(
    email: "anthony.joly@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Salim",
    nom: "Joly",
    email: "anthony.joly@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "I.T.").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "anthony.joly@erasme.ulb.ac.be").first,
    admin: true
)

User.create(
    email: "nicola.trotta@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Nicola",
    nom: "Trotta",
    email: "nicola.trotta@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "I.T.").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "nicola.trotta@erasme.ulb.ac.be").first
)

User.create(
    email: "eric.mulleneers@erasme.ulb.ac.be",
    password: "password"
)
Utilisateur.create(
    prenom: "Eric",
    nom: "Mulleneers",
    email: "eric.mulleneers@erasme.ulb.ac.be",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    user: User.where(email: "eric.mulleneers@erasme.ulb.ac.be").first
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
# CLASSES
#
Classe.create(
    nom: "Production"
)
Classe.create(
    nom: "Control Qualité"
)


#
# WORKS
#
Work.create(
    nom: "FDG 5h",
    code: "5",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    classe: Classe.first
)
Work.create(
    nom: "Contrôle qualité",
    code: "QC",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    classe: Classe.last
)
Work.create(
    nom: "Livraison",
    code: "L",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    classe: Classe.first
)
Work.create(
    nom: "Methionine",
    code: "M",
    groupe: Groupe.where(nom: "Operateur").first,
    service: Service.where(nom: "Cyclotron").first,
    classe: Classe.first
)


#
# FERMETURES
#
Fermeture.create(
    nom: "Nouvel An",
    date: "2020-01-01", 
    service: Service.first
)
Fermeture.create(
    nom: "Nouvel An",
    date: "2020-01-01", 
    service: Service.last
)
Fermeture.create(
    nom: "Noel",
    date: "2020-12-25", 
    service: Service.first
)
Fermeture.create(
    nom: "Noel",
    date: "2020-12-25", 
    service: Service.last
)
Fermeture.create(
    nom: "Fete Nationale",
    date: "2020-07-21", 
    service: Service.first
)
Fermeture.create(
    nom: "Fete Nationale",
    date: "2020-07-21", 
    service: Service.last
)
Fermeture.create(
    nom: "15 aout",
    date: "2020-08-15", 
    service: Service.first
)
Fermeture.create(
    nom: "15 aout",
    date: "2020-08-15", 
    service: Service.last
)
Fermeture.create(
    nom: "1er mai",
    date: "2020-05-01", 
    service: Service.first
)
Fermeture.create(
    nom: "ascension",
    date: "2020-05-21",
    date_fin: "2020-05-22",
    service: Service.first
)


#
# 
#