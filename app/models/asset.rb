class Asset < ActiveRecord::Base
  attr_accessible :company_id, :document
  belongs_to :company
  
  has_attached_file :document,
                  :url  => "/datafiles/:rails_env/assets/:id/:basename.:extension",
                  :path => ":rails_root/datafiles/:rails_env/assets/:id/:basename.:extension"
                  
  validates_attachment_content_type :document, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"],
             :message => ', Only PDF, EXCEL, WORD or TEXT files are allowed.'
  validates_attachment_size :document, :less_than => 5.megabytes 
end
