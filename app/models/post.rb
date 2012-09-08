class Post < ActiveRecord::Base

  before_create :create_slug

  belongs_to :user
  has_many :comments

  attr_accessible :content, :title, :post_type, :public

  validates_presence_of :content, :title, :post_type
  validates_length_of :content, :minimum => 10, :maximum => 2000
  validates_length_of :title, :maximum => 100

  default_scope order('created_at DESC')

  def month
    self.created_at.strftime('%b').upcase
  end

  def day
    self.created_at.strftime('%d')
  end

  def to_param
    slug
  end

  def create_slug
    self.slug = self.title.parameterize
  end
end
