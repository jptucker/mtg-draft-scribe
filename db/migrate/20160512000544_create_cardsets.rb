class CreateCardsets < ActiveRecord::Migration
  def change
    create_table :cardsets do |t|
      t.string :abbreviation
      t.string :name
    end
  end
end
