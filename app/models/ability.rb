class Ability
  include CanCan::Ability

  def initialize(user, action_token = nil)
    user ||= User.new

    if action_token
      can [:read, :update], Report, action_token: action_token
      can :update, StoryPoint, reports: { action_token: action_token }
      can [:read, :update], Story, reports: { action_token: action_token }
    else
      can [:read], StoryPoint, id: StoryPoint.readable(user).ids
      can [:create, :update, :destroy], StoryPoint, user_id: user.id
      can [:read, :create], Attachment, user_id: user.id
      can [:read], Story, id: Story.readable(user).ids
      can [:create, :update, :destroy], Story, user_id: user.id
      can :read, Profile
      can [:update], Profile, user_id: user.id
      can [:create, :destroy], Like, user_id: user.id
      can [:read], Following
      can [:create, :destroy], Following, user_id: user.id
      cannot [:create], Following do |follow|
        follow.followable == user
      end
      can :create, Report, user_id: user.id
      can [:read, :followed, :followers], User
      can [:update], User, id: user.id
      can :cities, Location
      can [:create, :destroy], Gadget, user_id: user.id
    end
  end
end
