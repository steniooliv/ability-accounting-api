class CreateAccountings < ActiveRecord::Migration[6.1]
  def change
    create_table :accountings do |t|
      t.string :name

      t.timestamps
    end
  end
end
