class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :image_url
      t.string :multiverse_id
      t.boolean :is_planeswalker
      t.boolean :is_land
      t.boolean :is_enchantment
      t.boolean :is_artifact
      t.boolean :is_sorcery
      t.boolean :is_instant
      t.boolean :is_creature
      t.boolean :is_colorless
      t.boolean :is_blue
      t.boolean :is_white
      t.boolean :is_red
      t.boolean :is_black
      t.boolean :is_green
      t.string :cmc
      t.string :name
    end
  end
end
