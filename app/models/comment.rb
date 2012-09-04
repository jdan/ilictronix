class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  attr_accessible :body, :post_id

  validates_presence_of :body, :post_id, :user_id
  validates_length_of :body, :minimum => 10, :maximum => 1000

  def timestamp
    self.created_at.strftime("%b %e at %l:%M %p")
  end
end
