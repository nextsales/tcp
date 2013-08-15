class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all2
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(request.env["omniauth.auth"])

    # Controll if the user is signin successfull or not
    if user.persisted?
      sign_in_and_redirect user
      flash.notice = "Signed in!"
    else
      session["devise.user_attributes"] = user.attributes
      #raise "shit".to_yaml
      redirect_to new_user_registration_url
    end

  end

  def facebook
    # raise request.env["omniauth.auth"].to_yaml
    # raise current_user.email.to_yaml
    auth = request.env["omniauth.auth"]
    if !current_user.facebook_authentication
      current_user.facebook_authentication = FacebookAuthentication.new(:uid => auth.uid, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :auth_token => auth.credentials.token, :expires_at => auth.credentials.expires_at, :raw_info => auth.extra.raw_info)
      flash.notice = "Authentication successful. Created user successfull"
    else
      flash.notice = "Authentication successful. User already exist"
    end

    redirect_to edit_user_registration_url
  end

  def linkedin1
    raise request.env["omniauth.auth"].to_yaml

    auth = request.env["omniauth.auth"]
    if !current_user.linkedin_auth
      current_user.linkedin_auth = LinkedinAuth.new(:uid => auth.uid, :full_name => auth.info.name, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :headline =>auth.info.headline, :industry =>auth.info.industry, :location =>auth.info.location, :phone =>auth.info.phone, :token => auth.credentials.token, :secret => auth.credentials.secret, :raw_auth => auth.extra.raw_info)
      flash.notice = "Authentication successful. Created user successfull"
    else
      flash.notice = "Authentication successful. User already exist"
    end
    
    redirect_to edit_user_registration_url
    
  end
  
  
  def linkedin
    if current_user
      auth = request.env["omniauth.auth"]
      
      if LinkedinAuth.find_by_uid(auth.uid)
        flash.notice = "This Linkedin account already exists. Add another Linkedin account"
      else
        current_user.linkedin_auth = LinkedinAuth.new(:uid => auth.uid, :full_name => auth.info.name, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :headline =>auth.info.headline, :industry =>auth.info.industry, :location =>auth.info.location, :phone =>auth.info.phone, :token => auth.credentials.token, :secret => auth.credentials.secret, :raw_auth => auth.extra.raw_info)
        current_user.linkedin_uid = auth.uid
        current_user.save
      end
      sign_in_and_redirect current_user
    else
      user = User.from_linkedin_auth(request.env["omniauth.auth"])
      
      if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_url
      end
    end
  end
  
  def twitter    
    if current_user
      auth = request.env["omniauth.auth"]
      
      if TwitterAuth.find_by_uid(auth.uid)  #your Twitter auth exits 
        flash.notice = "This Twitter account already exists. Add another Twitter account"
      else
        current_user.twitter_auth = TwitterAuth.create!(:uid => auth.uid, :name => auth.info.name, :nickname => auth.info.nickname, :provider => auth.provider, 
          :image => auth.info.image, :description =>auth.description, :location =>auth.info.location, :token => auth.credentials.token, 
          :secret => auth.credentials.secret, :origin_created_at => auth.extra.raw_info.created_at.to_datetime, :lang => auth.extra.raw_info.lang,
          :favourites_count => auth.extra.raw_info.favourites_count, :followers_count => auth.extra.raw_info.followers_count, :friends_count => auth.extra.raw_info.friends_count,
          :id_str => auth.extra.raw_info.id_str, :listed_count => auth.extra.raw_info.listed_count, :time_zone => auth.extra.raw_info.time_zone)
        current_user.twitter_uid = auth.uid
        current_user.save
      end 
      sign_in_and_redirect current_user
    else
      #raise request.env["omniauth.auth"].info.name.to_yaml
      user = User.from_twitter_auth(request.env["omniauth.auth"])     
      
      if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        session["devise.twitter_auth"] = user.twitter_auth
        redirect_to new_user_registration_url
      end
    
    end
  end
  

  # alias_method :facebook, :all
  # alias_method :linkedin, :all
end
