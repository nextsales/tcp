class MediaMatrixR < ActiveRecord::Base
  attr_accessible :matrix_id, :media_site_id
  belongs_to :media_site
  belongs_to :matrix
end
