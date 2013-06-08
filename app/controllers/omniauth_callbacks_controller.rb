class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
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

  def linkedin
    #raise request.env["omniauth.auth"].to_yaml

    auth = request.env["omniauth.auth"]
    if !current_user.linkedin_auth
      current_user.linkedin_auth = LinkedinAuth.new(:uid => auth.uid, :full_name => auth.info.name, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :email =>auth.info.email, :photo => auth.info.image, :headline =>auth.info.headline, :industry =>auth.info.industry, :location =>auth.info.location, :phone =>auth.info.phone, :token => auth.credentials.token, :secret => auth.credentials.secret, :raw_auth => auth.extra.raw_info)
      flash.notice = "Authentication successful. Created user successfull"
    else
      flash.notice = "Authentication successful. User already exist"
    end
    
    redirect_to edit_user_registration_url
    
  end

  # alias_method :facebook, :all
  # alias_method :linkedin, :all
end
