class CreateAccessors < ActiveRecord::Migration
  def self.up
    create_table :accessors do |t|
      t.integer :accessor_id
      t.integer :reference_id
      t.string  :reference_type
      t.string  :event
      t.string  :tag
      t.text    :meta 
      t.timestamps
    end
 
    change_table :accessors do |t|
      t.index [:reference_id, :reference_type]
      t.index :accessor_id
      t.index :event
      t.index :tag
      t.index :created_at
    end
  end
 
  def self.down
    drop_table :accessors
  end
end