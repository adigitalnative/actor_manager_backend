class AddCategoryToAuditions < ActiveRecord::Migration[5.2]
  def change
    add_reference :auditions, :category, foreign_key: true
  end
end
