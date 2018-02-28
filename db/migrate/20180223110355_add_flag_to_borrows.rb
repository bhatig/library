class AddFlagToBorrows < ActiveRecord::Migration
  def change
  	  add_column :borrows, :flag, :boolean, default: :false
  end
end
