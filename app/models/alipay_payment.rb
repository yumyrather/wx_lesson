class AlipayPayment < ActiveRecord::Base

  def payment_config
    options = {
      :req_data => {
        :out_trade_no  => self.out_trade_no,         # 20130801000001
        :subject       =>  self.subject,
        :total_fee     => "#{self.total_fee}",
        :call_back_url     => "http://115.29.189.26/mobile/wx_users/#{self.wx_user_id}", 
        :notify_url        => 'http://115.29.189.26/payment/alipay_payments/alipay_wap_notify'
      }
    }
  end
end