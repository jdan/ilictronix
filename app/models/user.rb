class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :roles, :through => :user_role

  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :username
  validates_presence_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :email

end
