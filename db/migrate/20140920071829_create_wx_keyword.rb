class CreateWxKeyword < ActiveRecord::Migration
  def change
    create_table :wx_keywords do |t|
      t.string :keyword
      t.string :keyword_type
      t.boolean :hidden,:default=>true
      t.timestamps
    end
    
    create_table :wx_articles do |t|
      t.string :title
      t.string :cover
      t.string :breif
      t.text :content, :limit => 4294967295
      t.boolean :hidden,:default=>true
      t.timestamps
    end
    
  end
end
