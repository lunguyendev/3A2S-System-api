class AddAvatarToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :avatar, :string
  end
end
