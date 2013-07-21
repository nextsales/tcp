class LinkedinUpdate < ActiveRecord::Base
  attr_accessible :linkedin_company_id, :raw_data, :update_key, :update_type, :created_at
  has_many :matrices
end
