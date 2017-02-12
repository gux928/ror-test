class RemoveTiffFromRecdocs < ActiveRecord::Migration[5.0]
  def change
    remove_column :rec_docs, :tiff, :string
  end
end
