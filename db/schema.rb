# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2020091012140633) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absences", force: :cascade do |t|
    t.bigint "type_absence_id"
    t.bigint "utilisateur_id"
    t.date "date"
    t.date "date_fin"
    t.string "remarque"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "accord"
    t.boolean "halfday"
    t.index ["type_absence_id"], name: "index_absences_on_type_absence_id"
    t.index ["utilisateur_id"], name: "index_absences_on_utilisateur_id"
  end

  create_table "ajouts", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.date "date"
    t.boolean "am_pm"
    t.integer "work1"
    t.integer "work2"
    t.integer "work3"
    t.integer "work4"
    t.integer "work5"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["utilisateur_id"], name: "index_ajouts_on_utilisateur_id"
  end

  create_table "blog_categories", force: :cascade do |t|
    t.string "nom"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "blog_messages", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.bigint "blog_category_id"
    t.bigint "service_id"
    t.string "title"
    t.string "keywords"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "date", precision: nil
    t.integer "groupe"
    t.integer "classe"
    t.boolean "logbook"
    t.boolean "reviewed"
    t.integer "reviewer"
    t.index ["blog_category_id"], name: "index_blog_messages_on_blog_category_id"
    t.index ["service_id"], name: "index_blog_messages_on_service_id"
    t.index ["utilisateur_id"], name: "index_blog_messages_on_utilisateur_id"
  end

  create_table "blog_responses", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.bigint "blog_message_id"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["blog_message_id"], name: "index_blog_responses_on_blog_message_id"
    t.index ["utilisateur_id"], name: "index_blog_responses_on_utilisateur_id"
  end

  create_table "bug_repports", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.date "date"
    t.string "nom"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "status"
    t.index ["utilisateur_id"], name: "index_bug_repports_on_utilisateur_id"
  end

  create_table "classes", force: :cascade do |t|
    t.string "nom"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "configurations", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "demande_conges", force: :cascade do |t|
    t.date "date"
    t.date "date_fin"
    t.date "date_demande"
    t.bigint "utilisateur_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["utilisateur_id"], name: "index_demande_conges_on_utilisateur_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "nom"
    t.date "date"
    t.string "note"
    t.bigint "service_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["service_id"], name: "index_events_on_service_id"
  end

  create_table "fermetures", force: :cascade do |t|
    t.string "nom"
    t.date "date"
    t.date "date_fin"
    t.string "note"
    t.bigint "service_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["service_id"], name: "index_fermetures_on_service_id"
  end

  create_table "groupes", force: :cascade do |t|
    t.string "nom"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "hebdos", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.integer "numero_semaine"
    t.string "note"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "task_id"
    t.bigint "year_id"
    t.bigint "service_id"
    t.index ["service_id"], name: "index_hebdos_on_service_id"
    t.index ["task_id"], name: "index_hebdos_on_task_id"
    t.index ["utilisateur_id"], name: "index_hebdos_on_utilisateur_id"
    t.index ["year_id"], name: "index_hebdos_on_year_id"
  end

  create_table "jours", force: :cascade do |t|
    t.bigint "utilisateur_id"
    t.bigint "service_id"
    t.string "numero_semaine"
    t.date "date"
    t.integer "numero_jour"
    t.boolean "am_pm"
    t.string "note"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["service_id"], name: "index_jours_on_service_id"
    t.index ["utilisateur_id"], name: "index_jours_on_utilisateur_id"
  end

  create_table "konfigurations", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "lieus", force: :cascade do |t|
    t.string "nom"
    t.text "adresse"
    t.string "phone"
    t.string "note"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "logs", force: :cascade do |t|
    t.datetime "date", precision: nil
    t.string "adresse"
    t.integer "utilisateur_id"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "service_id"
    t.string "note"
    t.date "date"
    t.date "date_fin"
    t.bigint "utilisateur_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["service_id"], name: "index_messages_on_service_id"
    t.index ["utilisateur_id"], name: "index_messages_on_utilisateur_id"
  end

  create_table "postits", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "level"
    t.boolean "is_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "utilisateur_id"
    t.index ["utilisateur_id"], name: "index_postits_on_utilisateur_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "lieu_id"
    t.string "nom"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["lieu_id"], name: "index_services_on_lieu_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "groupe_id"
    t.bigint "classe_id"
    t.bigint "service_id"
    t.string "nom"
    t.string "code"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "repeat"
    t.index ["classe_id"], name: "index_tasks_on_classe_id"
    t.index ["groupe_id"], name: "index_tasks_on_groupe_id"
    t.index ["service_id"], name: "index_tasks_on_service_id"
  end

  create_table "templates", force: :cascade do |t|
    t.boolean "am_pm1"
    t.integer "work1_1"
    t.integer "work1_2"
    t.integer "work1_3"
    t.integer "work1_4"
    t.integer "work1_5"
    t.boolean "am_pm2"
    t.integer "work2_1"
    t.integer "work2_2"
    t.integer "work2_3"
    t.integer "work2_4"
    t.integer "work2_5"
    t.boolean "am_pm3"
    t.integer "work3_2"
    t.integer "work3_3"
    t.integer "work3_4"
    t.integer "work3_5"
    t.boolean "am_pm4"
    t.integer "work4_1"
    t.integer "work4_2"
    t.integer "work4_3"
    t.integer "work4_4"
    t.integer "work4_5"
    t.boolean "am_pm5"
    t.integer "work5_1"
    t.integer "work5_2"
    t.integer "work5_3"
    t.integer "work5_4"
    t.integer "work5_5"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "nom"
    t.string "description"
    t.integer "service_id"
    t.integer "work3_1"
  end

  create_table "type_absences", force: :cascade do |t|
    t.string "code"
    t.string "nom"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "admin"
    t.datetime "last_connection", precision: nil
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.bigint "groupe_id"
    t.bigint "service_id"
    t.string "prenom"
    t.string "nom"
    t.string "email"
    t.string "phone"
    t.string "gsm"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.boolean "admin"
    t.datetime "last_connection", precision: nil
    t.boolean "inactive"
    t.index ["groupe_id"], name: "index_utilisateurs_on_groupe_id"
    t.index ["service_id"], name: "index_utilisateurs_on_service_id"
    t.index ["user_id"], name: "index_utilisateurs_on_user_id"
  end

  create_table "wiki_pages", force: :cascade do |t|
    t.integer "utilisateur_id"
    t.integer "blog_category_id"
    t.integer "service_id"
    t.integer "groupe_id"
    t.string "keywords"
    t.string "title"
    t.text "problem_description"
    t.text "solution_short"
    t.text "solution_long"
    t.integer "blog_message_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "working_lists", force: :cascade do |t|
    t.bigint "work_id"
    t.bigint "jour_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["jour_id"], name: "index_working_lists_on_jour_id"
    t.index ["work_id"], name: "index_working_lists_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.bigint "groupe_id"
    t.bigint "classe_id"
    t.bigint "service_id"
    t.string "nom"
    t.string "code"
    t.string "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "mark"
    t.integer "early_value"
    t.integer "length"
    t.integer "repeat"
    t.index ["classe_id"], name: "index_works_on_classe_id"
    t.index ["groupe_id"], name: "index_works_on_groupe_id"
    t.index ["service_id"], name: "index_works_on_service_id"
  end

  add_foreign_key "absences", "type_absences"
  add_foreign_key "absences", "utilisateurs"
  add_foreign_key "ajouts", "utilisateurs"
  add_foreign_key "blog_messages", "blog_categories"
  add_foreign_key "blog_messages", "services"
  add_foreign_key "blog_messages", "utilisateurs"
  add_foreign_key "blog_responses", "blog_messages"
  add_foreign_key "blog_responses", "utilisateurs"
  add_foreign_key "bug_repports", "utilisateurs"
  add_foreign_key "demande_conges", "utilisateurs"
  add_foreign_key "events", "services"
  add_foreign_key "fermetures", "services"
  add_foreign_key "hebdos", "tasks"
  add_foreign_key "hebdos", "utilisateurs"
  add_foreign_key "jours", "services"
  add_foreign_key "jours", "utilisateurs"
  add_foreign_key "messages", "services"
  add_foreign_key "messages", "utilisateurs"
  add_foreign_key "services", "lieus"
  add_foreign_key "tasks", "classes", column: "classe_id"
  add_foreign_key "tasks", "groupes"
  add_foreign_key "tasks", "services"
  add_foreign_key "utilisateurs", "groupes"
  add_foreign_key "utilisateurs", "services"
  add_foreign_key "utilisateurs", "users"
  add_foreign_key "working_lists", "jours"
  add_foreign_key "working_lists", "works"
  add_foreign_key "works", "classes", column: "classe_id"
  add_foreign_key "works", "groupes"
  add_foreign_key "works", "services"
end
