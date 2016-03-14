class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, StoryPoint
    can [:create, :update, :destroy], StoryPoint, user_id: user.id
    can [:read, :create], Attachment, user_id: user.id
    can [:create, :read, :update, :destroy], Story, user_id: user.id
    can :read, Profile
    can [:update], Profile, user_id: user.id

  end
end
