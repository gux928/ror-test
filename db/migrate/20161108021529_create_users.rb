class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :phone
      t.string :phone_short
      t.string :id_num
      t.string :office
      t.boolean :party_member
      t.integer :authority

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
    add_index :users, :phone_short, unique: true
    add_index :users, :id_num, unique: true
  end
end
