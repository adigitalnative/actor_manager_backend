class AddUserToAudition < ActiveRecord::Migration[5.2]
  def change
    add_reference :auditions, :user, foreign_key: true
  end
end
