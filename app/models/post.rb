class Post < ActiveRecord::Base
  attr_accessible :author, :content, :score, :title, :type
end
