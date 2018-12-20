class CreateAuditionPieces < ActiveRecord::Migration[5.2]
  def change
    create_table :audition_pieces do |t|
      t.references :book_item, foreign_key: true
      t.references :audition, foreign_key: true

      t.timestamps
    end
  end
end
