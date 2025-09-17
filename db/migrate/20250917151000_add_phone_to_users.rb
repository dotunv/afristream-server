# frozen_string_literal: true

class AddPhoneToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :phone_country, :string
    add_column :users, :phone_e164, :string

    add_index :users, :phone_e164, unique: true
  end
end
