class CreateParkCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :park_categories do |t|
      t.integer :score
      t.references :category, null: false, foreign_key: true
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
