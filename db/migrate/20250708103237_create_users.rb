class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :role

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :role
  end
end
