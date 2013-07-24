class MediaCompanyR < ActiveRecord::Base
  attr_accessible :company_id, :media_site_id
  belongs_to :media_site
  belongs_to :company
end
