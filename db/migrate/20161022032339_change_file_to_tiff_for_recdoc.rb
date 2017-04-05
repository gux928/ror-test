class ChangeFileToTiffForRecdoc < ActiveRecord::Migration[5.0]
  def change
    remove_column :rec_docs, :pic_file_name, :string
    add_column :rec_docs, :tiff, :string
  end
end
