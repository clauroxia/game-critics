class CreateInvolvedCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :involved_companies do |t|
      t.belongs_to :company
      t.belongs_to :game
      t.boolean :developer, default: false
      t.boolean :publisher, default: false

      t.timestamps
    end
  end
end
