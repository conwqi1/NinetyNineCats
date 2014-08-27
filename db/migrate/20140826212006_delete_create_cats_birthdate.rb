class DeleteCreateCatsBirthdate < ActiveRecord::Migration
  def change
    remove_column :cats, :birth_date
    add_column :cats, :birth_date, :date
    add_index :cats, :name, unique:true
  end
end
