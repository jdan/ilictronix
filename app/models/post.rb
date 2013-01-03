class Post < ActiveRecord::Base

  before_create :create_slug
  before_save :create_tags

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags

  attr_accessible :content, :title, :post_type, :public, :tag_list
  # why do I need this?!
  attr_accessor :tag_list

  validates_presence_of :content, :title #, :post_type
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
    self.slug
  end

  private
  def create_slug
    self.slug = self.title.parameterize
  end

  def create_tags
    self.tags = []
    self.tag_list.split.each do |t|
      self.tags << Tag.find_or_create_by_title(t)
    end
  end
end
