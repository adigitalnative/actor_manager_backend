class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.references :opportunity, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :new, null: false, default: true
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end
