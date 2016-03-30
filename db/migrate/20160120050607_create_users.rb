class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :name
      t.string :nickname
      t.string :image
      t.string :github_access_token
      t.string :github_id

      t.timestamps null: false

    end

    add_index :users, :github_id, :unique => true
  end
end
