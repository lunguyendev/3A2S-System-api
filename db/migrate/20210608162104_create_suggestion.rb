class CreateSuggestion < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :user_uid
      t.string :type_event_uid

      t.timestamps
    end
    add_foreign_key "suggestions", "type_events", column: "type_event_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
    add_foreign_key "suggestions", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
