class Asset < ActiveRecord::Base
  attr_accessible :company_id, :document
  belongs_to :company
  
  has_attached_file :document,
                  :url  => "/datafiles/:rails_env/assets/:id/:basename.:extension",
                  :path => ":rails_root/datafiles/:rails_env/assets/:id/:basename.:extension"
  
end
