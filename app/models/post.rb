class Post < ActiveRecord::Base
  attr_accessible :content, :title, :post_type

  default_scope order('created_at DESC')
end
