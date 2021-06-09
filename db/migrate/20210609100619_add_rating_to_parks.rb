class AddRatingToParks < ActiveRecord::Migration[6.0]
  def change
  	add_column :parks, :rating, :float
  end
end
