class SuggestedCompany < ActiveRecord::Base
  attr_accessible :country, :linkedin_id, :logo_url, :name, :rank, :raw_data, :user_id, :is_enable
  belongs_to :user
end
