class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present? 
      can :manage, Photo, user_id: user.id 
      can :manage, Album, user_id: user.id 
      can :manage, User, id: user.id
      if user.admin?
        can :manage, :all
      end
    end
  end

end