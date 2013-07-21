class Matrix < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :matrix_keywords
  
  has_many :company_matrix_rs, :dependent => :destroy
  has_many :companies, :through => :company_matrix_rs
  
  has_one :user_matrix_r
  has_one :user, :through => :user_matrix_r
  
  has_many :matrix_follower_rs, dependent: :destroy
  has_many :followers, :through => :matrix_follower_rs
  
  has_many :matrix_feed_rs
  has_many :feeds, :through => :matrix_feed_rs
  
  attr_reader :company_tokens
  attr_accessible :company_tokens, :company_ids
  
  def company_tokens=(ids)
    self.company_ids = ids.split(",")
  end
    
  def crawl_feed
    linkedin_client = self.user.linkedin_client
    
    self.companies.each do |company|
      crawl_linkedin_update(linkedin_client, company)
    end
  end
  
  # Should move to company crawl #
  def crawl_linkedin_update(linkedin_client, company)
    if (crawl_results = linkedin_client.company_updates({:id => company.linkedin_id, :count => 9999, :start => 0}).all)
      crawl_results.each do |update|
        linkedin_update = Feed.where(update_key: update.update_key).first_or_create(:raw_data => update.to_json, :update_key => update.update_key, :update_type => update.update_type, :created_at => update.timestamp)
        MatrixFeedR.find_or_create_by_matrix_id_and_feed_id(matrix_id: self.id, feed_id: linkedin_update.id)
      end
    end
  end
  
end