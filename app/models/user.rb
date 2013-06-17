class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :user_company_rs
  has_many :companies, :through => :user_company_rs
  
  has_many :user_matrix_rs
  has_many :matrices, :through => :user_matrix_rs
  
  has_many :matrix_follower_rs, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_matrices, :through => :matrix_follower_rs, source: :matrix
  
  has_one :linkedin_auth, dependent: :destroy
  
  def linkedin_client
    client = LinkedIn::Client.new("mky987r927xk", "J6mdxQRCxLzFylVG")
    client.authorize_from_access(linkedin_auth.token, linkedin_auth.secret)
    client
  end
  
  def self.from_linkedin_auth(auth)
    where(:linkedin_uid => auth.uid).first_or_create do |user|
      user.linkedin_uid = auth.uid
      user.email = auth.info.email
      user.linkedin_auth = LinkedinAuth.new(:uid => auth.uid, :full_name => auth.info.name, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :headline =>auth.info.headline, :industry =>auth.info.industry, :location =>auth.info.location, :phone =>auth.info.phone, :token => auth.credentials.token, :secret => auth.credentials.secret, :raw_auth => auth.extra.raw_info)
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && linkedin_uid.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  def test
    client = LinkedIn::Client.new("mky987r927xk", "J6mdxQRCxLzFylVG")
    client.authorize_from_access(linkedin_auth.token, linkedin_auth.secret)
    
    company = []
    start = 0
    count = 25
    
    while (true)
       query = client.following_companies(:start => start, :count => count)
       company = company + query.all
       start = start + count
       break if (start > query.total) 
    end
    
    company_data = []
    company.each do |company|
      company_data.push( linkedin_client.company(:id => company.id, :fields => %w{ id name logo-url}) )
    end
    
    company_data
    
  end
end
