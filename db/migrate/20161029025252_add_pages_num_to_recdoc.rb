class AddPagesNumToRecdoc < ActiveRecord::Migration[5.0]
  def change
    add_column :rec_docs, :png_num , :string
  end
end
