class CreateCritics < ActiveRecord::Migration[7.0]
  def change
    create_table :critics do |t|
      t.string :title
      t.text :body
      t.boolean :approved, default: false
      t.references :criticable, polymorphic: true

      t.timestamps
    end
  end
end
