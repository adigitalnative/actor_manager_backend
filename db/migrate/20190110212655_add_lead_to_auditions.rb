class AddLeadToAuditions < ActiveRecord::Migration[5.2]
  def change
    add_reference :auditions, :lead, foreign_key: true
  end
end
