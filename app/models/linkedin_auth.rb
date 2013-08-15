class LinkedinAuth < ActiveRecord::Base
  attr_accessible :email, :first_name, :full_name, :headline, :industry, :last_name, :location, :phone, :photo, :raw_auth, :secret, :token, :uid
  belongs_to :user
end
