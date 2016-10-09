class AddSomeToRecDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :rec_docs, :from1111, :string
    add_column :rec_docs, :from_code, :string
    add_column :rec_docs, :from_num, :string
    add_column :rec_docs, :year, :int
    add_column :rec_docs, :year_num, :int
  end
end
