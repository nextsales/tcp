class Industry < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :company_industry_rs, :dependent => :destroy
  has_many :companies, :through => :company_industry_rs
  
  def self.tokens(query)
    industries = where("name like ?", "%#{query}%")
    if industries.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      industries
    end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) {create!(name: $1).id }
    tokens.split(',')
  end
end