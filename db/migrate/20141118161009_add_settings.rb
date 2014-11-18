class AddSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.string :key
      t.text :value
      t.timestamps
    end
  end
end
