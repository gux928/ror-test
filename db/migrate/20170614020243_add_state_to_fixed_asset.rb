class AddStateToFixedAsset < ActiveRecord::Migration[5.0]
  def change
    add_column :fixed_assets, :state, :string
  end
end
