class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :number, null: false
      t.index :number, unique: true
      t.decimal :amount, :precision => 19, :scale => 2, default: 0.00
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
