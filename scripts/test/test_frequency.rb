@wx_lesson = WxLesson.find(1)
@user = WxUser.find(285)
result = @wx_lesson.has_sign?(@user)
puts result

@another_user = WxUser.find(1)
puts @wx_lesson.sign_lesson(@another_user)