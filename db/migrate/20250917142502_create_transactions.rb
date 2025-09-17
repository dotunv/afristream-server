class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true
      t.integer :amount_cents, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.string :provider
      t.string :reference

      t.timestamps
    end
    add_index :transactions, :status
    add_index :transactions, :reference, unique: true
  end
end
