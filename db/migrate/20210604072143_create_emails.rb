class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails, id: false do |t|
      t.string :uid, null: false, primary_key: true
      t.string :title
      t.string :content
      t.string :list_email, array: true, default: []
      t.string :send_by

      t.timestamps
    end
  end
end
