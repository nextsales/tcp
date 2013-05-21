class CompanyCompetenceR < ActiveRecord::Base
  attr_accessible :company_id, :competence_id
  belongs_to :company
  belongs_to :competence
end
