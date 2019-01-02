class CreateOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :opportunities do |t|
      t.string :source
      t.string :title
      t.string :company
      t.string :url
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
