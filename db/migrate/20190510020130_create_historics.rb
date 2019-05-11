class CreateHistorics < ActiveRecord::Migration[5.2]
  def change
    create_table :historics do |t|
      t.integer :source_id
      t.integer :destination_id
      t.decimal :amount, :precision => 19, :scale => 2, null: false, default: 0.00

      t.timestamps
    end
  end
end
