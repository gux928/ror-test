class CreateFixedAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :fixed_assets do |t|
      t.string :number
      t.string :belongs_to
      t.string :main_class
      t.string :sub_class
      t.string :serial_number
      t.string :month_of_purchase
      t.string :position
      t.string :brand
      t.string :model
      t.string :remarks
      t.string :user
      t.string :unit_price
      t.string :invoice
      t.string :photo




      t.timestamps
    end
  end
end
