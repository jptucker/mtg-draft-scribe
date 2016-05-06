class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :card_id
      t.string :draft_id
      t.boolean :is_sideboard
    end
  end
end
