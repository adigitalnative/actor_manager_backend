class RemoveResultFromReport < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reports, :result, foreign_key: true
  end
end
