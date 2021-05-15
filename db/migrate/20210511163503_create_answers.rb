class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.integer :scope
      t.string :comment
      t.string :question_uid
      t.string :user_uid

      t.timestamps
    end
    add_index :answers, :uid, unique: true
    add_foreign_key "answers", "questions", column: "question_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
    add_foreign_key "answers", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
