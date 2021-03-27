class CreateTakePartInEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :take_part_in_events, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :user_uid
      t.string :event_uid
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :take_part_in_events, :uid, unique: true
    add_foreign_key "take_part_in_events", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
    add_foreign_key "take_part_in_events", "events", column: "event_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
