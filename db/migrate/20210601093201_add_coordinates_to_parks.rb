class AddCoordinatesToParks < ActiveRecord::Migration[6.0]
  def change
    add_column :parks, :latitude, :float
    add_column :parks, :longitude, :float
  end
end
