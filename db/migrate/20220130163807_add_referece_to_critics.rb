class AddRefereceToCritics < ActiveRecord::Migration[7.0]
  def change
    add_reference :critics, :user, null: false, foreign_key: true
  end
end
