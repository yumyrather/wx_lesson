@sys_users = SysAppUser.all
@sys_users.each do |app_user|
  username = app_user.USERNAME
  @users = WxUser.where("username = ?",username)
  if @users.any?
    @user = @users[0]
    puts "#{username} exist"
  else
    @user = WxUser.new
  end
  @user.username = app_user.USERNAME
  @user.password = app_user.PASSWORD
  @user.name = app_user.NAME
  @user.rights = app_user.RIGHTS
  @user.wx_role_id = app_user.ROLE_ID.to_i
  @user.status = app_user.STATUS
  @user.remark = app_user.BZ
  @user.phone = app_user.PHONE
  @user.start_time = DateTime.parse(app_user.START_TIME) if app_user.START_TIME
  @user.end_time = DateTime.parse(app_user.END_TIME) if app_user.END_TIME
  @user.year = app_user.YEARS
  @user.open_id = app_user.WEIXINID
  @user.save
end