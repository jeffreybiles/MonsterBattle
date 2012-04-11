class CreateSpeciesMoves < ActiveRecord::Migration
  def change
    create_table :species_moves do |t|
      t.integer :species_id
      t.integer :move_id
      t.integer :level_learned

      t.timestamps
    end
  end
end
