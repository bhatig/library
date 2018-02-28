class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :edition
      t.integer :price
      t.references :author
      t.timestamps null: false
    end
  end
end
