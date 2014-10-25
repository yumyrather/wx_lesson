class AddFrequencyToWxLessons < ActiveRecord::Migration
  def change
    add_column :wx_lessons,:frequency,:string,:default=>"每周"
    
    create_table :wx_lesssons_sign_logs do |t|
      t.integer :wx_lesson_id
      t.integer :wx_user_id
      t.timestamps
    end
  end
end
