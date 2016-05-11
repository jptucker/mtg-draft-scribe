class CreateSets < ActiveRecord::Migration
  def change
    create_table :sets do |t|
      t.string :abbreviation
      t.string :name
    end
  end
end
