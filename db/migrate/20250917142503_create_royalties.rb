class CreateRoyalties < ActiveRecord::Migration[8.0]
  def change
    create_table :royalties do |t|
      t.bigint :creator_id
      t.references :content, null: false, foreign_key: true
      t.integer :amount_cents, default: 0, null: false
      t.string :period

      t.timestamps
    end
    add_index :royalties, :creator_id
    add_foreign_key :royalties, :users, column: :creator_id
  end
end
