class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :country
      t.references :user
      t.references :author
      t.timestamps null: false
    end
  end
end
