class AddImageToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :image, :json
  end
end
