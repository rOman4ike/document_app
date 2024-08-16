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

ActiveRecord::Schema[7.0].define(version: 2024_08_16_043745) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_areas", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "change_orders", force: :cascade do |t|
    t.string "number"
    t.datetime "change_date"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.string "state", default: "active"
    t.datetime "deleted_at"
    t.index ["document_id"], name: "index_change_orders_on_document_id"
  end

  create_table "doc_tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_activity_areas", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "activity_area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_area_id"], name: "index_document_activity_areas_on_activity_area_id"
    t.index ["document_id"], name: "index_document_activity_areas_on_document_id"
  end

  create_table "document_doc_tags", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "doc_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doc_tag_id"], name: "index_document_doc_tags_on_doc_tag_id"
    t.index ["document_id"], name: "index_document_doc_tags_on_document_id"
  end

  create_table "document_files", force: :cascade do |t|
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "deleted_at"
    t.string "state", default: "active"
    t.index ["document_id"], name: "index_document_files_on_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.string "kind"
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_public", default: true
  end

  create_table "initial_orders", force: :cascade do |t|
    t.string "number"
    t.datetime "initial_date"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.index ["document_id"], name: "index_initial_orders_on_document_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "change_orders", "documents"
  add_foreign_key "document_activity_areas", "activity_areas"
  add_foreign_key "document_activity_areas", "documents"
  add_foreign_key "document_doc_tags", "doc_tags"
  add_foreign_key "document_doc_tags", "documents"
  add_foreign_key "document_files", "documents"
  add_foreign_key "initial_orders", "documents"
end
