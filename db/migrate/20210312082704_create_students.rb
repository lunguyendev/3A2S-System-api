class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string, :name
      t.string, :email
      t.string :hashed_password
      t.string :string,
      t.string :phone
      t.string :string,
      t.string :status
      t.string :integer,
      t.string :gender
      t.string :integer,
      t.string :birthday
      t.string :date,
      t.string :class_activity
      t.string :string,
      t.string :id_student
      t.string :string

      t.timestamps
    end
  end
end
