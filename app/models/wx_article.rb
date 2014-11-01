class WxArticle < ActiveRecord::Base
  has_many :wx_keyword_items,dependent: :destroy
  mount_uploader :cover, ArticleCoverUploaderUploader
  
  acts_as_cached(:version => 1, :expires_in => 1.week)

   

  # blog viewer hit counter
  def increment_view_count
    
    increment(:view_count)        # add view_count += 1
    write_second_level_cache      # update cache per hit, but do not touch db
                                  # update db per 10 hits
    self.class.update_all({:view_count => view_count}, :id => id) if view_count % 10 == 0
  end
end