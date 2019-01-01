class AddSearchToState < ActiveRecord::Migration[5.2]
  def change
    add_column :states, :search, :boolean, null: false, default: false
  end
end
