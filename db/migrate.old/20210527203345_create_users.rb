class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, :limit => 60
      t.string :email, :limit => 60
      t.string :password_digest
      t.references :accounting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
