# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200407131638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.bigint "type_absence_id"
    t.bigint "utilisateur_id"
    t.date "date"
    t.string "remarque"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_fin"
    t.index ["type_absence_id"], name: "index_absences_on_type_absence_id"
    t.index ["utilisateur_id"], name: "index_absences_on_utilisateur_id"
  end

  create_table "ajouts", force: :cascade do |t|
    t.integer "utilisateur"
    t.integer "numero_jour"
    t.date "date_lundi"
    t.integer "work1"
    t.integer "work2"
    t.integer "work3"
    t.integer "work4"
    t.integer "work5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "am_pm"
  end

  create_table "classes", force: :cascade do |t|
    t.string "nom"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_id"
    t.index ["work_id"], name: "index_classes_on_work_id"
  end

  create_table "conges", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.date "date"
    t.boolean "accord"
    t.string "remarque"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_fin"
    t.index ["utilisateur_id"], name: "index_conges_on_utilisateur_id"
  end

  create_table "fermetures", force: :cascade do |t|
    t.string "nom"
    t.date "date"
    t.date "date_fin"
    t.string "note"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_fermetures_on_service_id"
  end

  create_table "groupes", force: :cascade do |t|
    t.string "nom"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "semaine_id"
    t.integer "numero_jour"
    t.boolean "am_pm"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id"
    t.index ["semaine_id"], name: "index_jobs_on_semaine_id"
    t.index ["service_id"], name: "index_jobs_on_service_id"
  end

  create_table "lieus", force: :cascade do |t|
    t.string "nom"
    t.text "adresse"
    t.string "phone"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semaines", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.string "numero_semaine"
    t.date "date_lundi"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_semaines_on_slug"
    t.index ["utilisateur_id"], name: "index_semaines_on_utilisateur_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "lieu_id"
    t.string "nom"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lieu_id"], name: "index_services_on_lieu_id"
  end

  create_table "type_absences", force: :cascade do |t|
    t.string "code"
    t.string "nom"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.bigint "groupe_id"
    t.bigint "service_id"
    t.string "prenom"
    t.string "nom"
    t.date "date_de_naissance"
    t.string "email"
    t.string "phone"
    t.string "gsm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["groupe_id"], name: "index_utilisateurs_on_groupe_id"
    t.index ["service_id"], name: "index_utilisateurs_on_service_id"
  end

  create_table "working_lists", force: :cascade do |t|
    t.bigint "work_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_working_lists_on_job_id"
    t.index ["work_id"], name: "index_working_lists_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.bigint "groupe_id"
    t.string "nom"
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "classe_id"
    t.bigint "service_id"
    t.index ["classe_id"], name: "index_works_on_classe_id"
    t.index ["groupe_id"], name: "index_works_on_groupe_id"
    t.index ["service_id"], name: "index_works_on_service_id"
  end

  add_foreign_key "absences", "type_absences"
  add_foreign_key "absences", "utilisateurs"
  add_foreign_key "conges", "utilisateurs"
  add_foreign_key "fermetures", "services"
  add_foreign_key "jobs", "semaines"
  add_foreign_key "jobs", "services"
  add_foreign_key "semaines", "utilisateurs"
  add_foreign_key "services", "lieus"
  add_foreign_key "utilisateurs", "groupes"
  add_foreign_key "utilisateurs", "services"
  add_foreign_key "working_lists", "jobs"
  add_foreign_key "working_lists", "works"
  add_foreign_key "works", "groupes"
  add_foreign_key "works", "services"
end
