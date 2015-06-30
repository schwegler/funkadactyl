class CreateDinos < ActiveRecord::Migration
  def change
    create_table :dinos do |t|
      t.string :name
      t.integer :species_id

      t.timestamps null: false
    end
  end
end
