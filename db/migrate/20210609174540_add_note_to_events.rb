class AddNoteToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :note, :string
  end
end
