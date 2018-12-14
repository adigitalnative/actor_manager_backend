class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :pre
      t.text :in_room
      t.text :post
      t.references :audition, foreign_key: true

      t.timestamps
    end
  end
end
