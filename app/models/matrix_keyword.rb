class MatrixKeyword < ActiveRecord::Base
  attr_accessible :matrix_id, :name
  belongs_to :matrix
end
