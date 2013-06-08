class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :user_company_rs
  has_many :companies, :through => :user_company_rs
  
  has_many :user_matrix_rs
  has_many :matrices, :through => :user_matrix_rs
  
  has_many :matrix_follower_rs, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_matrices, :through => :matrix_follower_rs, source: :matrix
  
  has_one :linkedin_auth
  
end
