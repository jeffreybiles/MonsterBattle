class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :name
      t.decimal :damage
      t.decimal :hit_chance

      t.timestamps
    end
  end
end
