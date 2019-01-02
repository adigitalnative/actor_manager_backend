class AddActiveToOpportunities < ActiveRecord::Migration[5.2]
  def change
    add_column :opportunities, :active, :boolean, null: false, default: true
  end
end
