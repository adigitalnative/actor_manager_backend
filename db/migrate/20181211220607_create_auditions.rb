class CreateAuditions < ActiveRecord::Migration[5.2]
  def change
    create_table :auditions do |t|
      t.text :bring
      t.text :prepare

      t.timestamps
    end
  end
end
