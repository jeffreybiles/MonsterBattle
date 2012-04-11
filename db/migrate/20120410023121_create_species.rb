class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species do |t|
      t.string :name
      t.decimal :hp_growth
      t.decimal :attack_growth
      t.decimal :defense_growth
      t.timestamps
    end
  end

  def self.down
    drop_table :species
  end
end
