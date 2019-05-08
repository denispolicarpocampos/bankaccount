class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_digest, null: false
      t.string :cpf
      t.index :cpf, unique: true
      t.string :cnpj
      t.index :cnpj, unique: true

      t.timestamps
    end
  end
end
