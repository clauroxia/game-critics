class AddCounterCacheToGameAndCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :critics_count, :integer, default: 0
    add_column :companies, :critics_count, :integer, default: 0
  end
end
