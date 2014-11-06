# encoding: utf-8
# 1, @weixin_message: 获取微信所有参数.
# 2, @weixin_public_account: 如果配置了public_account_class选项,则会返回当前实例,否则返回nil.
# 3, @keyword: 目前微信只有这三种情况存在关键字: 文本消息, 事件推送, 接收语音识别结果
WeixinRailsMiddleware::WeixinController.class_eval do
  include Rails.application.routes.url_helpers
  require 'chinese'
  

    
  def server_path
    "http://www.xubokai.net"
  end
  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end

  def articles_list_by_keyword(keyword,user)
    arts = []
    if user.nil?
      @articles = keyword.wx_articles.where("public_flag = ?",true)
    else
      @articles = keyword.wx_articles
    end
    
    @articles.each do |article|
      cover_url = article.cover.nil? ? "" : "#{server_path}#{article.cover_url(:normal)}"
      art = generate_article("#{article.title}", "#{article.breif}", "#{cover_url}",mobile_wx_article_url(article))
      arts << art
    end
    # 商城首页
    arts
  end
  
  
  private

    def response_text_message(options={})
      @gbk_keyword = @keyword.to_gbk
      @wx_keyword = WxKeyword.find_by :keyword => [@keyword,@gbk_keyword]
      logger.info("keyword in database and input:#{@wx_keyword.try(:keyword)} |#{@keyword}|#{@gbk_keyword}") 
      if @wx_keyword
        @user = WxUser.find_by_open_id( @weixin_message.FromUserName )
        
        @articles = articles_list_by_keyword(@wx_keyword,@user)
        if @articles.any?
          reply_news_message(@articles)
        else
          ""
        end
      else
        ""
      end
    end

    # <Location_X>23.134521</Location_X>
    # <Location_Y>113.358803</Location_Y>
    # <Scale>20</Scale>
    # <Label><![CDATA[位置信息]]></Label>
    def response_location_message(options={})
      @lx    = @weixin_message.Location_X
      @ly    = @weixin_message.Location_Y
      @scale = @weixin_message.Scale
      @label = @weixin_message.Label
      reply_text_message("Your Location: #{@lx}, #{@ly}, #{@scale}, #{@label}")
    end

    # <PicUrl><![CDATA[this is a url]]></PicUrl>
    # <MediaId><![CDATA[media_id]]></MediaId>
    def response_image_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      @pic_url  = @weixin_message.PicUrl  # 也可以直接通过此链接下载图片, 建议使用carrierwave.
      reply_image_message(generate_image(@media_id))
    end

    # <Title><![CDATA[公众平台官网链接]]></Title>
    # <Description><![CDATA[公众平台官网链接]]></Description>
    # <Url><![CDATA[url]]></Url>
    def response_link_message(options={})
      @title = @weixin_message.Title
      @desc  = @weixin_message.Description
      @url   = @weixin_message.Url
      reply_text_message("回复链接信息")
    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <Format><![CDATA[Format]]></Format>
    def response_voice_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      @format   = @weixin_message.Format
      # 如果开启了语音翻译功能，@keyword则为翻译的结果
      # reply_text_message("回复语音信息: #{@keyword}")
      reply_voice_message(generate_voice(@media_id))
    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <ThumbMediaId><![CDATA[thumb_media_id]]></ThumbMediaId>
    def response_video_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      # 视频消息缩略图的媒体id，可以调用多媒体文件下载接口拉取数据。
      @thumb_media_id = @weixin_message.ThumbMediaId
      reply_text_message("回复视频信息")
    end

    def response_event_message(options={})
      event_type = @weixin_message.Event
      send("reply_#{event_type.downcase}_event")
    end

    private

      # 关注公众账号
      def reply_subscribe_event
        if @keyword.present?
          # 扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送
          return reply_text_message("扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送, keyword: #{@keyword}")
        end
        reply_text_message("关注公众账号")
      end

      # 取消关注
      def reply_unsubscribe_event
        Rails.logger.info("取消关注")
      end

      # 扫描带参数二维码事件: 2. 用户已关注时的事件推送
      def reply_scan_event
        reply_text_message("扫描带参数二维码事件: 2. 用户已关注时的事件推送, keyword: #{@keyword}")
      end

      def reply_location_event # 上报地理位置事件
        @lat = @weixin_message.Latitude
        @lgt = @weixin_message.Longitude
        @precision = @weixin_message.Precision
        reply_text_message("Your Location: #{@lat}, #{@lgt}, #{@precision}")
      end

      # 点击菜单拉取消息时的事件推送
      def reply_click_event
        if @keyword == "BUTTON_1_1"
          @user = WxUser.find_by_open_id( @weixin_message.FromUserName )
          if @user
            @wx_lesson = WxLesson.first
            #进行签到
            @wx_lesson.sign_lesson(@user)
            #获取签到动作后的学习进度
            @study_record = @wx_lesson.wx_lesson_user_records.find_by_wx_user_id(@user.id)
            
            logger.info("lesson size : #{@wx_lesson.wx_chapters.size}")
            logger.info("study_record id and step : #{@study_record.id} & #{@study_record.now_chatpter}")
   
            
            @chatpers = @wx_lesson.wx_chapters.where("no > 0 and no is not null and no <= ?",@study_record.now_chatpter).order("no desc")
            arts = []
            
            cover_url = @wx_lesson.cover.nil? ? "" : "#{server_path}#{@wx_lesson.cover_url(:normal)}"
            title = generate_article("#{@wx_lesson.title}", "", "#{cover_url}",mobile_wx_lesson_url(@wx_lesson))
            arts << title
            
             @chatpers.each do |chapter|
              cover_url = chapter.cover.nil? ? "" : "#{server_path}#{chapter.cover_url(:normal)}"
              art = generate_article("#{chapter.title}", "第#{chapter.no}章", "#{cover_url}",mobile_wx_chapter_url(chapter))
              arts << art
            end
            reply_news_message(arts)
          else
            reply_text_message("您无法浏超越极限进阶课程。如您已是我们的会员,请点击会员中心进行登录后，再次点击该菜单,用户最新的课程信息。")
          end
          
        elsif @keyword == "BUTTON_3_1"
          arts = []
          cover_url = "#{server_path}"+"/images/wx/reg_logo.png"
          art = generate_article("会员中心", "高级会员登入", "#{cover_url}",mobile_signin_url)
          arts << art
          reply_news_message(arts)
          
        else
         
           @wx_keyword = WxKeyword.find_by_keyword(@keyword)
            if @wx_keyword  && @wx_keyword.active?

              @user = WxUser.find_by_open_id( @weixin_message.FromUserName )

              @articles = articles_list_by_keyword(@wx_keyword,@user)
              if @articles.any?
                reply_news_message(@articles)
              else
                reply_text_message("")
              end
            else
              reply_text_message("")
            end
         
        end
      end

      # 点击菜单跳转链接时的事件推送
      def reply_view_event
        Rails.logger.info("你点击了: #{@keyword}")
      end

end
