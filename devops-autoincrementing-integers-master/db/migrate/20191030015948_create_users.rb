class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, length: 255, null: false
      t.string :password_digest, length: 255, null: false
      t.string :api_key, length: 255, null: false
      t.timestamps
    end
  end
end
