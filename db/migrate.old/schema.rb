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

ActiveRecord::Schema.define(version: 2021_06_11_135027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountings", force: :cascade do |t|
    t.string "name", limit: 60
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_postgresql_files", force: :cascade do |t|
    t.oid "oid"
    t.string "key"
    t.index ["key"], name: "index_active_storage_postgresql_files_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", limit: 60
    t.bigint "number"
    t.bigint "accounting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accounting_id"], name: "index_companies_on_accounting_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", limit: 60
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_products", force: :cascade do |t|
    t.integer "product_id"
    t.string "description", limit: 100
    t.float "quantity"
    t.float "price_unitary"
    t.float "price_total"
    t.float "discount_value"
    t.float "expenses_value"
    t.float "shipping_value"
    t.float "safe_value"
    t.string "icms_cst_csosn", limit: 4
    t.float "icms_base"
    t.float "icms_value"
    t.float "sticms_base"
    t.float "sticms_value"
    t.string "ipi_cst", limit: 2
    t.float "ipi_base"
    t.float "ipi_value"
    t.string "pis_cst", limit: 2
    t.float "pis_base"
    t.float "pis_value"
    t.string "cofins_cst", limit: 2
    t.float "cofins_base"
    t.float "cofins_value"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_products_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "number"
    t.string "serie", limit: 3
    t.string "model", limit: 2
    t.string "type_record", limit: 4
    t.string "type_movement", limit: 1
    t.date "date_issue"
    t.date "date_departure"
    t.string "access_key", limit: 44
    t.float "total_product"
    t.float "discount_value"
    t.float "expenses_value"
    t.float "shipping_value"
    t.float "safe_value"
    t.float "icms_base"
    t.float "icms_value"
    t.float "sticms_base"
    t.float "sticms_value"
    t.float "ipi_base"
    t.float "ipi_value"
    t.float "pis_base"
    t.float "pis_value"
    t.float "cofins_base"
    t.float "cofins_value"
    t.float "invoice_value"
    t.bigint "company_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "email", limit: 60
    t.string "password_digest"
    t.bigint "accounting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accounting_id"], name: "index_users_on_accounting_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "accountings"
  add_foreign_key "invoice_products", "invoices"
  add_foreign_key "invoices", "companies"
  add_foreign_key "invoices", "customers"
  add_foreign_key "users", "accountings"
end
