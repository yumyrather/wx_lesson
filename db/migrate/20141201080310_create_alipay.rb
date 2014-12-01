class CreateAlipay < ActiveRecord::Migration
  def change
    create_table :alipay_payments do |t|
      t.integer :wx_user_id
      t.string :out_trade_no
      t.string :trade_no
      t.string :subject
      t.string :body
      t.decimal :total_fee,:default=>0, :precision => 20, :scale => 2
      t.integer :quantity
      t.datetime :paid_at
      t.timestamps 
    end
    
    create_table :alipay_feedbacks do |t|
      t.string :out_trade_no
      t.string :trade_no
      t.string :buyer_email
      t.string :seller_email
      t.string :notify_type
      t.string :trade_status
      
      t.string :buyer_id
      t.string :notify_id
      t.datetime :gmt_create_at
      t.datetime :gmt_close_at
      t.datetime :notify_time_at
      
      t.decimal :total_fee,:default=>0, :precision => 20, :scale => 2
      t.integer :quantity
      t.datetime :paid_at
      t.timestamps
    end
    
  end
end
