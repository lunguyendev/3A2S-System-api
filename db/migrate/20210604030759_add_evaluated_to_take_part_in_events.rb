class AddEvaluatedToTakePartInEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :take_part_in_events, :evaluated, :boolean, default: false
  end
end
