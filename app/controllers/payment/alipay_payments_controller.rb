class  Payment::AlipayPaymentsController < Payment::BaseController  
  require 'digest/md5' 
  
  
  skip_before_filter :verify_authenticity_token,:only => :alipay_wap_notify  
  
  
  def index
    Alipay.pid = '2088211609440258'
    Alipay.key = 'mk96m21cti3xhfpxkzfkt2kkplvmebfx'
    Alipay.seller_email = 'hp@goal101.com'
    
    user_id = params[:user_id]
    

    md5 = Digest::MD5.hexdigest(user_id.to_s)
    trade_no = "#{Time.now.strftime("%Y%m%d%H%M%S")}#{md5}"
    
    @wx_user = WxUser.find(user_id)
    @alipay = AlipayPayment.new
    @alipay.wx_user_id = @wx_user.id
    @alipay.total_fee = 0.01
    @alipay.out_trade_no = trade_no
    @alipay.subject = "测试用的"
    @alipay.save
    options = @alipay.payment_config
    token = Alipay::Service::Wap.trade_create_direct_token(options)
    redirect_to Alipay::Service::Wap.auth_and_execute(request_token: token)
  end
  
  
  def alipay_wap_notify
    # except :controller_name, :action_name, :host, etc.
    notify_params = params.except(*request.path_parameters.keys)
    logger.info("ver params is #{params}")
    
    if Alipay::Notify::Wap.verify?(notify_params)
      # valid notify, code your business logic.
      # you may want to get you order id:
      order_id = Hash.from_xml(params[:notify_data])['notify']['out_trade_no']
      logger.info("notify_date is #{Hash.from_xml(params[:notify_data])['notify']}")
      
      @feedback = AlipayFeedback.build_with_feedback(Hash.from_xml(params[:notify_data])['notify'])
      @feedback.save
      @feedback.update_payment
      logger.info("order_id is #{order_id} success")
      
      render :text => 'success'
    else
      render :text => 'error'
    end
  end
  
end