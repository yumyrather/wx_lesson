class CreateWxKeyword < ActiveRecord::Migration
  def change
    create_table :wx_keywords do |t|
      t.string :keyword
      t.string :keyword_type
      t.boolean :hidden,:default=>true
      t.timestamps
    end
  end
end
