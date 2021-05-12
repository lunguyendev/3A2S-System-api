class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :template_feedback_uid
      t.boolean :is_rating
      t.string :content

      t.timestamps
    end
    add_index :questions, :uid, unique: true
    add_foreign_key "questions", "template_feedbacks", column: "template_feedback_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  end
end
