class  Payment::AlipayPaymentsController < Payment::BaseController  
  def index
    Alipay.pid = '2088211609440258'
    Alipay.key = 'mk96m21cti3xhfpxkzfkt2kkplvmebfx'
    Alipay.seller_email = 'hp@goal101.com'
    
    options = {
      :out_trade_no      => '20130801000001',         # 20130801000001
      :subject           => '测试用的',   # Writings.io Base Account x 12
      :logistics_type    => 'DIRECT',
      :logistics_fee     => '0',
      :logistics_payment => 'SELLER_PAY',
      :price             => '1.00',
      :quantity          => 1,
      :discount          => '1.00',
      :return_url        => 'http://www.xubokai.net', # https://writings.io/orders/20130801000001
      :notify_url        => 'http://www.xubokai.net'  # https://writings.io/orders/20130801000001/alipay_notify
    }
    
    redirect_to Alipay::Service.create_direct_pay_by_user_url(options)
    
  end
end