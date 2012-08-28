class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_and_belongs_to_many :roles
  has_many :posts

  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :username
  validates_presence_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  def has_role?(r)
    self.roles.where(:title => r.to_s).any?
  end

end
