class CreateWxKeywordItem < ActiveRecord::Migration
  def change
    create_table :wx_keyword_items do |t|
      t.integer :wx_keyword_id
      t.integer :wx_article_id
      t.integer :priority
      t.timestamps
    end
  end
end
