class AddDetailsToParks < ActiveRecord::Migration[6.0]
  def change
    add_column :parks, :details, :text
  end
end
