@keyword_items = WxKeywordItem.all

@keyword_items.each do |item|
  unless item.wx_article && item.wx_keyword
    item.destroy
    puts "remove item #{item.id}"
  end
end