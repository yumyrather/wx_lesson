require "open-uri"
require "nokogiri"

@articles = WxArticle.all

@articles.each do |article|
  if article.content.index("http://mp.weixin.qq.com/")
    url =  article.content.strip
     @html = open(url)
     doc = Nokogiri::HTML(@html)
     rich_text = doc.css("div.rich_media_content")[0].to_s[48..-7]
     article.content  = rich_text.gsub("data-src","src")
     article.save
     puts  rich_text
  end
end