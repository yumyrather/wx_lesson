class AddReviewAndLikeIntoArtilce < ActiveRecord::Migration
  def change
    add_column :wx_articles,:like_count,:integer,:default=>0,:null=>false
    add_column :wx_articles,:view_count,:integer,:default=>0,:null=>false
    add_column :wx_articles,:share_count,:integer,:default=>0,:null=>false
  end
end
