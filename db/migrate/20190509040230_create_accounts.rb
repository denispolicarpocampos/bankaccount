class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :number, null: false
      t.index :number, unique: true
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
