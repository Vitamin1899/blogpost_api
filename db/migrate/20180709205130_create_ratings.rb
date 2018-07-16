class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.float :value
      t.references :post, index: true, foreign_key: true

      t.timestamps
    end
  end
end
