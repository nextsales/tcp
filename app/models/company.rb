class Company < ActiveRecord::Base
  attr_accessible :address, :city, :country, :description, :email, :facebook_id, :linkedin_id, :name, :phone, :postcode, :twitter_id, :website, :logo_url
  
  #validates :user_id, presence: true
  
  has_one :user_company_r
  has_one :user, :through => :user_company_r
  
  has_many :company_industry_rs, :dependent => :destroy
  has_many :competences, :through => :company_competence_rs

  has_many :company_competence_rs, :dependent => :destroy
  has_many :industries, :through => :company_industry_rs
  
  has_many :company_matrix_rs, :dependent => :destroy
  has_many :matrices, :through => :company_matrix_rs
  
  has_many :feeds, :dependent => :destroy
  has_many :media_feeds, :dependent => :destroy
  has_many :manual_feeds, :dependent => :destroy
  has_many :facebook_feeds, :dependent => :destroy
  has_many :twitter_feeds, :dependent => :destroy
  has_many :linkedin_feeds, :dependent => :destroy
  
end
