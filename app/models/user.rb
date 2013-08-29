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
  
  has_many :suggested_companies, dependent: :destroy
  
  has_many :user_matrix_rs
  has_many :matrices, :through => :user_matrix_rs
  
  has_many :matrix_follower_rs, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_matrices, :through => :matrix_follower_rs, source: :matrix
  
  has_one :linkedin_auth, dependent: :destroy
  has_one :twitter_auth, dependent: :destroy
  
  def linkedin_client
    client = LinkedIn::Client.new(OMNI_AUTH_CONFIG['LINKEDIN_APP_ID'], OMNI_AUTH_CONFIG['LINKEDIN_APP_SECRET'])
    client.authorize_from_access(linkedin_auth.token, linkedin_auth.secret)
    client
  end
  
  def twitter_client
    return nil unless twitter_auth
    client = Twitter::Client.new(
      :consumer_key => OMNI_AUTH_CONFIG['TWITTER_CONSUMER_KEY'],
      :consumer_secret => OMNI_AUTH_CONFIG['TWITTER_CONSUMER_SECRET'],
      :oauth_token => twitter_auth.token,
      :oauth_token_secret => twitter_auth.secret
    )
    client
  end
  
  def self.from_linkedin_auth(auth)
    where(:linkedin_uid => auth.uid).first_or_create do |user|
      user.linkedin_uid = auth.uid
      user.email = auth.info.email
      user.linkedin_auth = LinkedinAuth.new(:uid => auth.uid, :full_name => auth.info.name, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :headline =>auth.info.headline, :industry =>auth.info.industry, :location =>auth.info.location, :phone =>auth.info.phone, :token => auth.credentials.token, :secret => auth.credentials.secret, :raw_auth => auth.extra.raw_info)
      # user.matrices.push(Matrix.create(name: "Customers"), Matrix.create(name: "Competitors"))
    end
  end
  
  def self.from_twitter_auth(auth)
    where(:twitter_uid => auth.uid).first_or_create do |user|
      user.twitter_uid = auth.uid
      user.twitter_auth = TwitterAuth.new(:uid => auth.uid, :name => auth.info.name, :nickname => auth.info.nickname, :provider => auth.provider, 
        :image => auth.info.image, :description =>auth.description, :location =>auth.info.location, :token => auth.credentials.token, 
        :secret => auth.credentials.secret, :origin_created_at => auth.extra.raw_info.created_at.to_datetime,:lang => auth.extra.raw_info.lang,
        :favourites_count => auth.extra.raw_info.favourites_count, :followers_count => auth.extra.raw_info.followers_count, :friends_count => auth.extra.raw_info.friends_count,
        :id_str => auth.extra.raw_info.id_str, :listed_count => auth.extra.raw_info.listed_count, :time_zone => auth.extra.raw_info.time_zone)
    end
  end
  
  
  def self.new_with_session(params, session)
    if session["devise.twitter_auth"]
      super.tap do |user|
        auth = session["devise.twitter_auth"]
        user.twitter_uid = auth.uid
        user.twitter_auth = TwitterAuth.new(:uid => auth.uid, :name => auth.name, :nickname => auth.nickname, :provider => auth.provider, :image => auth.image, 
        :description =>auth.description, :location =>auth.location, :token => auth.token, :secret => auth.secret, :origin_created_at => auth.created_at,
        :favourites_count => auth.favourites_count, :followers_count => auth.followers_count, :friends_count => auth.friends_count, :lang => auth.lang,
        :id_str => auth.id_str, :listed_count => auth.listed_count, :time_zone => auth.time_zone)        
        user.attributes = params        
        user.valid?
      end
    elsif session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params        
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && (linkedin_uid.blank?&&twitter_uid.blank?)
  end
  
  def email_required?
    super && (linkedin_uid.blank?&&twitter_uid.blank?)
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
