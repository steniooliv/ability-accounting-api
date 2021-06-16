class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, :limit => 60
      t.bigint :number, :limit => 14
      t.references :accounting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
