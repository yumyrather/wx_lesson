class  Payment::AlipayPaymentsController < Payment::BaseController  
  require 'digest/md5' 
  
  
  skip_before_filter :verify_authenticity_token,:only => :alipay_wap_notify  
  
  
  def index
    Alipay.pid = '2088211609440258'
    Alipay.key = 'mk96m21cti3xhfpxkzfkt2kkplvmebfx'
    Alipay.seller_email = 'hp@goal101.com'
    
    user_id = params[:user_id]
    
    md5 = Digest::MD5.hexdigest(user_id.to_s)
    logger.info("uuid is #{md5}")
    trade_no = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{md5}"
    
    
    @wx_user = WxUser.find(user_id)
    
    
    options = {
      :req_data => {
        :out_trade_no  => "#{trade_no}",         # 20130801000001
        :subject       => '测试用的',   # Writings.io Base Account x 12
        :total_fee     => '0.01',
        :call_back_url        => "http://115.29.189.26/mobile/wx_users/#{@wx_user.id}", # https://writings.io/orders/20130801000001
        :notify_url        => 'http://115.29.189.26/payment/alipay_payments/alipay_wap_notify'  # https://writings.io/orders/20130801000001/alipay_notify
      }
    }

    token = Alipay::Service::Wap.trade_create_direct_token(options)
    redirect_to Alipay::Service::Wap.auth_and_execute(request_token: token)
  end
  
  
  def alipay_wap_notify
    # except :controller_name, :action_name, :host, etc.
    logger.info("ver params is #{params}")
    notify_params = params.except(*request.path_parameters.keys)
    
    if Alipay::Notify::Wap.verify?(notify_params)
      # valid notify, code your business logic.
      # you may want to get you order id:
      order_id = Hash.from_xml(params[:notify_data])['notify']['out_trade_no']
      logger.info("order_id is #{order_id} success")
      render :text => 'success'
    else
      render :text => 'error'
    end
  end
  
end