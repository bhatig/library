class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.date :issue_date
      t.date :due_date
      t.date :return_date
      t.integer :fine
      t.references :user
      t.references :book
      t.timestamps null: false
    end
  end
end
