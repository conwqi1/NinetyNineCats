class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :age, null: false
      # TODO: Drop birth_date and recreate as t.date
      t.string :birth_date, null: false 
      t.string :color, null: false 
      t.string :name, null: false, unique: true
      t.string :sex, null: false
      t.text :description
      
      t.timestamps
    end
  end
end
