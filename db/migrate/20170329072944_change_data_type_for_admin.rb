class ChangeDataTypeForAdmin < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :admin, :integer
  end
end
