class CreateBookItems < ActiveRecord::Migration[5.2]
  def change
    create_table :book_items do |t|
      t.string :title
      t.string :role
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
