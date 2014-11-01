
require "open-uri"
url = "https://mmbiz.qlogo.cn/mmbiz/LHJ4OG7B6HZk5afxiambjafP2NJEpvicrzcMcXt0bGFAthZNHsUiboTPF3ZRianqickj829Dq2uDPyLSPFVibWOFdySA/0"
data=open(url){|f|f.read}
filepath = "public/uploads/wx_article/cover/test/image.jpg"
if(File.exist?("public/uploads/wx_article/cover/test"))
 puts "folder structure already exist!"
else
  Dir.mkdir("public/uploads/wx_article/cover/test") #if folder not exist,then creat it.
end
open(filepath,"wb"){|f|f.write(data)}
