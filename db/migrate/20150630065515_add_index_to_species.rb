class AddIndexToSpecies < ActiveRecord::Migration
  def change
    add_index :species, :diet
  end
end
