class ChangeColumnsInCompanies < ActiveRecord::Migration[6.1]
  def change
    change_column :companies, :number, :string
    add_column :companies, :last_record, :datetime
  end
end