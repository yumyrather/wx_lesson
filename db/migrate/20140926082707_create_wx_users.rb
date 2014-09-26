class CreateWxUsers < ActiveRecord::Migration
  def change
    create_table :wx_users do |t|
      t.string :open_id
      t.string :username
      t.string :name
      t.string :rights
      t.string :role
      t.datetime :last_login
      t.string :ip
      t.string :status
      t.string :bz
      t.string :phone
      t.datetime :start_time
      t.datetime :end_time
      t.integer :year,:default=>0
      t.timestamps
    end
    
    create_table :wx_lessons do |t|
      t.string :title
      t.string :cover
      t.text :content, :limit => 4294967295
      t.integer :wx_chapters_count
      t.boolean :public_flag,:default=>true
      t.timestamps
    end
    
    create_table :wx_chapters do |t|
      t.integer :wx_lesson_id
      t.string :title
      t.integer :no
      t.string :cover
      t.text :content, :limit => 4294967295
      t.integer :reader_counter,:default=>0
      t.boolean :public_flag,:default=>true
      t.timestamps
    end
  end
end
