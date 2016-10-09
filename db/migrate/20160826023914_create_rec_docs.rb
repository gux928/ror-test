class CreateRecDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :rec_docs do |t|
      t.text :wjnr
      t.date :riqi

      t.timestamps
    end
  end
end
