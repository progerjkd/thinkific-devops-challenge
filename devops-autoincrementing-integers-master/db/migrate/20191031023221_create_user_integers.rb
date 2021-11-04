# frozen_string_literal: true

class CreateUserIntegers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_integers do |t|
      t.integer :value, default: 1, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
