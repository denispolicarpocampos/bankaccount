class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, User,  id: user.id
      can :read, Account, user_id: user.id
    end
  end
end