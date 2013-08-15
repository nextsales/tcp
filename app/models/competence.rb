class Competence < ActiveRecord::Base
  attr_accessible :description, :name, :is_approve
  has_many :company_competence_rs, :dependent => :destroy
  has_many :companies, :through => :company_competence_rs
  
  def self.tokens(query)
    competences = where("name like ?", "%#{query}%")
    if competences.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      competences
    end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) {create!(name: $1).id }
    tokens.split(',')
  end
end
