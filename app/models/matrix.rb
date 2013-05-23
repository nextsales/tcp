class Matrix < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :company_matrix_rs, :dependent => :destroy
  has_many :companies, :through => :company_matrix_rs
  
  has_many :feeds, :dependent => :destroy
  has_many :media_feeds, :dependent => :destroy
  has_many :manual_feeds, :dependent => :destroy
  has_many :facebook_feeds, :dependent => :destroy
  has_many :twitter_feeds, :dependent => :destroy
  has_many :linkedin_feeds, :dependent => :destroy
  
  has_one :user_matrix_r
  has_one :user, :through => :user_matrix_r
  
  has_many :follower_matrix_rs
  has_many :users, :through => :follower_matrix_rs
end