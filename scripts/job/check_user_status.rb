@wx_users = WxUser.all
@wx_users.each do |user|
  if user.active?
    user.update_attribute(:status, WxUser::OK_STATUS)
  else
    user.update_attribute(:status, WxUser::BLOCK_STATUS)
  end
end