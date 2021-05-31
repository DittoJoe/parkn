class CreateParks < ActiveRecord::Migration[6.0]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :address
      t.string :region

      t.timestamps
    end
  end
end
