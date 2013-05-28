class MatrixFollowerR < ActiveRecord::Base
  attr_accessible :follower_id, :matrix_id
  
  belongs_to :follower, class_name: "User"
  belongs_to :matrix
end
