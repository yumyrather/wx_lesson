class AlipayFeedback < ActiveRecord::Base
  
  def self.build_with_feedback(hash_feedback)
     feedback = AlipayFeedback.new
     feedback.out_trade_no = hash_feedback['out_trade_no']
     feedback.trade_no = hash_feedback['trade_no']
     feedback.buyer_email = hash_feedback['buyer_email']
     feedback.seller_email = hash_feedback['seller_email']
     feedback.notify_type = hash_feedback['notify_type']
     feedback.trade_status = hash_feedback['trade_status']
     feedback.buyer_id = hash_feedback['buyer_id']
     feedback.notify_id = hash_feedback['notify_id']
     feedback.gmt_create_at = hash_feedback['gmt_create']
     feedback.gmt_close_at = hash_feedback['gmt_close']
     feedback.notify_time_at = hash_feedback['notify_time']
     feedback.total_fee = hash_feedback['total_fee'].to_f
     feedback.paid_at = Time.now
     return feedback
  end
  
  
  def update_payment
    payment = AlipayPayment.find_by(:out_trade_no => self.out_trade_no)
    
    if payment
      payment.paid_at = self.paid_at
      payment.trade_no = self.trade_no
      
      payment.save
    end
  end
end