class CreateCages < ActiveRecord::Migration
  def change
    create_table :cages do |t|
      t.integer :capacity
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
