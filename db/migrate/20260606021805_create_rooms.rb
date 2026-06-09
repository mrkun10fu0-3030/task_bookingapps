class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :address
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
