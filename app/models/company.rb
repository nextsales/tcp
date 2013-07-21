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
  
  attr_reader :competence_tokens, :industry_tokens, :matrix_tokens, :add_matrix
  attr_accessible :competence_tokens, :industry_tokens, :matrix_tokens, :matrix_ids, :industry_ids, :competence_ids, :add_matrix
  
  def competence_tokens=(tokens)
    self.competence_ids = Competence.ids_from_tokens(tokens).uniq
  end
  
  def industry_tokens=(ids)
    self.industry_ids = ids.split(",")
  end
  
  def matrix_tokens=(ids)
    self.matrix_ids = ids.split(",")
  end
  
  def add_matrix=(id)
    self.matrix_ids = self.matrix_ids.push(id)
  end
  
  def crawl_linkedin_update
    self.user.linkedin_client.company_updates({:id => self.linkedin_id, :count => 9999, :start => 0}).all.each do |update|
      if LinkedinUpdate.find_by_update_key(update.update_key)
        return
      end
      LinkedinUpdate.create(:linkedin_company_id => self.linkedin_id, :raw_data => update.to_json, :update_key => update.update_key, :update_type => update.update_type, :created_at => update.timestamp)
    end
  end
  
end
