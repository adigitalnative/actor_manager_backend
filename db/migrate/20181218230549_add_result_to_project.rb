class AddResultToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :result, foreign_key: true
  end
end
