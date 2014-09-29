class LessonUserRecords < ActiveRecord::Migration
  def change
     create_table :wx_lesson_user_records do |t|
        t.integer :wx_lesson_id
        t.integer :wx_user_id
        t.datetime :last_signin
        t.integer :now_chatpter
        t.timestamps
      end
  end
end
