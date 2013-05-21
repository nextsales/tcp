class UserMatrixR < ActiveRecord::Base
  attr_accessible :matrix_id, :user_id
  belongs_to :matrix
  belongs_to :user
end
