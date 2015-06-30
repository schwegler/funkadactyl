class AddCageIdToDinos < ActiveRecord::Migration
  def change
    add_column :dinos, :cage_id, :integer
  end
end
