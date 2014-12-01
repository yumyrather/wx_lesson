class AddWxMenu < ActiveRecord::Migration
  def change
    create_table :wx_menus do |t|
      t.integer :public_account_id
      t.integer :parent_id # 所属父级菜单，如果当前是父级菜单，则此值为空
      t.string :name
      t.string :key  
      t.string :url
      t.boolean :is_show ,:default=>true# 是否显示
      t.integer :sort    # 排序功能
      t.timestamps
    end
       
    add_index :wx_menus, :public_account_id
    add_index :wx_menus, :parent_id
    add_index :wx_menus, :key
  end
end
