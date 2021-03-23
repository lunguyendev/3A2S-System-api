class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :name
      t.string :type
      t.string :email
      t.string :hashed_password
      t.string :phone
      t.integer :status
      t.integer :gender
      t.date :birthday
      t.text :class_activity
      t.string :id_student
      t.string :id_lecturer
      t.integer :role

      t.timestamps
    end
    add_index :users, :uid, unique: true
    add_index :users, :email
  end
end
