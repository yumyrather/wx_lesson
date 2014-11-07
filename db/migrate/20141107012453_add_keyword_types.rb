class AddKeywordTypes < ActiveRecord::Migration
  def change
    add_column :wx_articles,:is_linked,:boolean,:default=>false
    add_column :wx_articles,:linked_url,:string
    remove_column :wx_articles,:post_date
    add_column :wx_articles,:published_at,:date
  end
end
