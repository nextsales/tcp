class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :user_company_rs
  has_many :companies, :through => :user_company_rs
  
  has_many :user_matrix_rs
  has_many :matrices, :through => :user_matrix_rs
  
  has_many :follower_matrix_rs
  has_many :matrices, :through => :follower_matrix_rs
end
