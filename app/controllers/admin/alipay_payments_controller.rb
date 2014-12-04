class Admin::AlipayPaymentsController <  Admin::BaseController
  
  def index
    @page_title = "支付订单管理"
    @q = AlipayPayment.search(params[:q])
    @payments = @q.result(distinct: true)
    @payments_grid = initialize_grid(@payments,:per_page => 50)
  end
end