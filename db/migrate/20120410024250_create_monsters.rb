class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :custom_name
      t.integer :level
      t.decimal :experience
      t.integer :user_id
      t.integer :species_id

      t.timestamps
    end
  end
end
