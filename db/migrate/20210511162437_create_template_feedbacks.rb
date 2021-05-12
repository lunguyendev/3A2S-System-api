class CreateTemplateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :template_feedbacks, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.boolean :is_online
      t.string :sheet_id
      t.string :name_sheet
      t.string :event_uid

      t.timestamps
    end
    add_index :template_feedbacks, :uid, unique: true
    add_foreign_key "template_feedbacks", "events", column: "event_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
