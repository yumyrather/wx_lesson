class Setting < ActiveRecord::Base
  validates :name,:key,:value,:presence => true
  
end