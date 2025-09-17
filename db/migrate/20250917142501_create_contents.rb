class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.integer :price_cents, default: 0, null: false
      t.jsonb :subtitle_languages, default: {}, null: false
      t.boolean :watermark_applied, default: false, null: false
      t.boolean :encrypted, default: false, null: false
      t.text :cek_ciphertext
      t.bigint :creator_id

      t.timestamps
    end
    add_index :contents, :creator_id
    add_index :contents, :subtitle_languages, using: :gin
    add_foreign_key :contents, :users, column: :creator_id
  end
end
