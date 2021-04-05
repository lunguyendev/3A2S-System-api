class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :qr_code_id
      t.string :qr_code_type
      t.string :qr_code_string
      t.integer :status
      t.datetime :expired_at

      t.timestamps
    end
    add_index :tokens, :qr_code_string, unique: true
    add_index :tokens, :qr_code_id, unique: true
  end
end
