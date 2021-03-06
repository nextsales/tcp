class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      
      # Company rule
      can :read, Company
      can :add_to_matrix, Company
      can :search, Company
      can :create, Company
      can :update, Company do |company|
        company.try(:user) == user
      end
      can :destroy, Company do |company|
        company.try(:user) == user
      end
      
      # Competence rule
      can :read, Competence
      
      
      # Industry rule
      can :read, Industry
      
      # Matrix rule
      can :read, Matrix do |matrix|
        matrix.try(:user) == user
      end
      can :read, Matrix do |matrix|
        matrix.try(:followers).include? user
      end
      can :create, Matrix
      
      can :add_follower, Matrix
      
      can :update, Matrix do |matrix|
        matrix.try(:user) == user
      end
      can :destroy, Matrix do |matrix|
        matrix.try(:user) == user
      end
      can :add, Matrix
      can :feed, Matrix
      
    end

  end
end
