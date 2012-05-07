class ChangeMonstersCustomNameAndAddAnimationToMoves < ActiveRecord::Migration
  def change
    rename_column :monsters, :custom_name, :name
    rename_column :moves, :damage, :power
    add_column :moves, :animation, :string
  end
end
