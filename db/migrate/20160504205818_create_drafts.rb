class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :user_id
      t.string :set3
      t.string :set2
      t.string :set1
      t.string :color3
      t.string :color2
      t.string :color1
    end
  end
end
