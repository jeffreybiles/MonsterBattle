class AddCurrentAndMaxStatsToMonsters < ActiveRecord::Migration
  def change
    change_table(:monsters) do |t|
      t.decimal :max_hp
      t.decimal :max_attack
      t.decimal :max_defense
      t.decimal :current_hp
      t.decimal :current_attack
      t.decimal :current_defense
    end
  end
end
