class CompanyMatrixR < ActiveRecord::Base
  attr_accessible :company_id, :is_approved, :matrix_id
  belongs_to :company
  belongs_to :matrix
end
