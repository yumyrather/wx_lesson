require "open-uri"

filename = "scripts/keyword.txt"

@i = 0
def process(text)
  @i += 1
  keyword_reg = "\\$Message=='\\S+'\\|"
  keyword_line =  text.match keyword_reg
  keyword = keyword_line.to_s.split("'")[1]
  
  @keyword = WxKeyword.find_by_keyword(keyword)
  
  if @keyword.nil?
    @keyword = WxKeyword.create(:keyword=>keyword)
    @keyword.save
  end

  
  reply_reg = "'news',(\\D|\\d)+\\);"
  reply_line =  text.match reply_reg
  reply_line = reply_line.to_s.delete("\);")
  params =  reply_line.split(',')
  puts params
  title = params[1].delete("'").delete("\"").strip
  intro = params[2].delete("'").delete("\"").strip
  image_url = params[3].delete("'").delete("\"").strip
  url = params[4].delete("'").delete("\"").strip
  
  @article = WxArticle.find_by_title(title)
  
  if @article.nil?
    @article = WxArticle.create

  end
  
  @article.title = title
  @article.breif = intro
  @article.content = url
  @article.write_uploader('cover', "image.jpg") 
  
  @article.save
  
  
  @keyword_item = WxKeywordItem.where("wx_keyword_id = ? and wx_article_id = ?",@keyword.id,@article.id)
  
  if @keyword_item.empty?
    @keyword_item = WxKeywordItem.new
    @keyword_item.wx_keyword_id = @keyword.id
    @keyword_item.wx_article_id = @article.id
    @keyword_item.save
  end
  
   data=open(image_url){|f|f.read}
    filepath = "public/uploads/wx_article/cover/#{@article.id}/image.jpg"
    if(File.exist?("public/uploads/wx_article/cover/#{@article.id}"))
     puts "folder structure already exist!"
    else
      Dir.mkdir("public/uploads/wx_article/cover/#{@article.id}") #if folder not exist,then creat it.
    end
    open(filepath,"wb"){|f|f.write(data)}
  
end

File.open(filename, "r") do |file|  
   while line=file.gets
     #段落
     if line.include?("if(")
       paragrah = ""   
     elsif line.include?("}")
       paragrah << line.chomp
       
       process(paragrah)
       

     end
     paragrah << line.chomp
     

     
   end
end


puts @i

