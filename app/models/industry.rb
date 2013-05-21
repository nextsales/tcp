class Industry < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :company_industry_rs, :dependent => :destroy
  has_many :companies, :through => :company_industry_rs
end
