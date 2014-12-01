class WxMenu < ActiveRecord::Base
  validates :name,:presence => true

  CLICK_TYPE = "click" # key
  VIEW_TYPE  = "view"  # url

  has_many :sub_menus, ->{where(is_show: true).order("sort").limit(5)}, class_name: "WxMenu", foreign_key: :parent_id, dependent: :destroy

  def self.parent_menus
    WxMenu.includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3)
  end

  def has_sub_menu?
    sub_menus.present?
  end

  # 优先为 click 类型
  def type
    key.present? ? CLICK_TYPE : VIEW_TYPE
  end

  def button_type(jbuilder)
    is_view_type? ? (jbuilder.url url) : (jbuilder.key key)
  end

  def is_view_type?
    type == VIEW_TYPE
  end
  
  
  def self.build_from_json(json)
    
  end
  
  def self.build_menu
    parent_menus = WxMenu.includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3)
    Jbuilder.encode do |json|
      json.button (parent_menus) do |menu|
        json.name menu.name
        if menu.has_sub_menu?
          json.sub_button(menu.sub_menus) do |sub_menu|
            json.type sub_menu.type
            json.name sub_menu.name
            sub_menu.button_type(json)
          end
        else
          json.type menu.type
          menu.button_type(json)
        end
      end
    end
  end
    
    
end