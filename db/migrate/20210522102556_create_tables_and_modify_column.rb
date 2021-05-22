class CreateTablesAndModifyColumn < ActiveRecord::Migration[6.0]
  def change
    create_table :type_events, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :name

      t.timestamps
    end
    add_index :type_events, :uid, unique: true
    add_index :type_events, :name, unique: true
    
    create_table :calendars, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :id_calendar
      t.string :meet_url
      t.string :event_uid

      t.timestamps
    end
    add_index :calendars, :uid, unique: true
    add_index :calendars, :event_uid, unique: true
    add_foreign_key "calendars", "events", column: "event_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade

    remove_column :events, :type_event
    add_column :events, :type_event_uids, :string, array: true
    add_column :events, :is_online, :boolean
  end
end
