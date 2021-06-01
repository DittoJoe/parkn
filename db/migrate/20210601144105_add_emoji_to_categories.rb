class AddEmojiToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :emoji, :string
  end
end
