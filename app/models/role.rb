class Role < ActiveRecord::Base

  has_many :users, :through => :user_role

  attr_accessible :title
end
