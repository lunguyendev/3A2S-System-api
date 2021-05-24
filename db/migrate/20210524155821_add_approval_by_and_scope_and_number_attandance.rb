class AddApprovalByAndScopeAndNumberAttandance < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :scope, :integer, default: 0
    add_column :events, :handel_by, :string
    add_column :events, :number_attandance, :integer, default: 0
  end
end
