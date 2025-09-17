class CreateLicenses < ActiveRecord::Migration[8.0]
  def change
    create_table :licenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true
      t.string :device_id, null: false
      t.string :license_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
    add_index :licenses, [:user_id, :content_id, :device_id], unique: true, name: "index_licenses_on_user_content_device"
    add_index :licenses, :license_token, unique: true
  end
end
