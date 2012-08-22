class Post < ActiveRecord::Base
  attr_accessible :content, :title, :post_type
end
