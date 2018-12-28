class CreateSearchStates < ActiveRecord::Migration[5.2]
  def change
    create_table :search_states do |t|
      t.references :user, foreign_key: true
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
