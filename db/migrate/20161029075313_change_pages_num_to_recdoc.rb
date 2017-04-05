class ChangePagesNumToRecdoc < ActiveRecord::Migration[5.0]
  def change
    remove_column :rec_docs, :png_num, :string
    add_column :rec_docs, :png_num, :integer
  end
end
