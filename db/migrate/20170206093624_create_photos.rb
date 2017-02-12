class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :imageable, polymorphic: true
      t.string :file_name
      t.integer :order

      t.timestamps
    end
  end
end
