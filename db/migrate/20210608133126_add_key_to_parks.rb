class AddKeyToParks < ActiveRecord::Migration[6.0]
  def change
    add_column :parks, :key, :string
  end
end
