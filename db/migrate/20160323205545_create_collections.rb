class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :collecter_id
      t.integer :collected_id
      t.timestamps null: false
    end
    add_index :collections, :collecter_id
    add_index :collections, :collected_id
    add_index :collections, [:collecter_id, :collected_id], unique: true
  end
end
