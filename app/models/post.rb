class Post < ActiveRecord::Base

  belongs_to :user

  attr_accessible :content, :title, :post_type

  default_scope order('created_at DESC')

  def month
    self.created_at.strftime('%b').upcase
  end

  def day
    self.created_at.strftime('%d')
  end
end
