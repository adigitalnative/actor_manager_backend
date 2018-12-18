class AddAuthorToBookItems < ActiveRecord::Migration[5.2]
  def change
    add_column :book_items, :author, :string
  end
end
