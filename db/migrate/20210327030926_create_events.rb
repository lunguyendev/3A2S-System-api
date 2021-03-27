class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :user_uid
      t.integer :type_event
      t.integer :size
      t.string :organization
      t.string :description
      t.integer :status, null: false, default: 0
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    add_index :events, :uid, unique: true
    add_foreign_key "events", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
