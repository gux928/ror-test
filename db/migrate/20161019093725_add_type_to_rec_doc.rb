class AddTypeToRecDoc < ActiveRecord::Migration[5.0]
  def change
    add_column :rec_docs, :doc_type, :integer
  end
end
