class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :audition, foreign_key: true
      t.references :result, foreign_key: true
      t.text :notes
      t.text :people
      t.text :auditors

      t.timestamps
    end
  end
end
