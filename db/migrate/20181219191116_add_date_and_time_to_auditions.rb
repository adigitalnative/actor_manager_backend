class AddDateAndTimeToAuditions < ActiveRecord::Migration[5.2]
  def change
    add_column :auditions, :date_and_time, :datetime
  end
end
