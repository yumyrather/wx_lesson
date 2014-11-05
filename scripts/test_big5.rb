require 'iconv'

s = "超越"
cov = Iconv.new("utf-8","gbk")
p cov.iconv(s)