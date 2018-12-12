class AddProjectToAuditions < ActiveRecord::Migration[5.2]
  def change
    add_reference :auditions, :project, foreign_key: true
  end
end
