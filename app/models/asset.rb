class Asset < ActiveRecord::Base
  attr_accessible :company_id, :document
  belongs_to :company
  
  has_attached_file :document,
                  :url  => "/assets/companies/:id/:basename.:extension",
                  :path => ":rails_root/datafiles/assets/companies/:id/:basename.:extension"
end
