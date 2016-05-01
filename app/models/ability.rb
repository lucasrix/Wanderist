class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read], StoryPoint
    can [:create, :update, :destroy], StoryPoint, user_id: user.id
    can [:read, :create], Attachment, user_id: user.id
    can [:create, :index, :update, :destroy], Story, user_id: user.id
    can [:read], Story
    can :read, Profile
    can [:update], Profile, user_id: user.id
    can [:create, :destroy], Like, user_id: user.id
    can [:read], Following
    can [:create, :destroy], Following, user_id: user.id
    cannot [:create], Following do |follow|
      follow.followable == user
    end
    can [:read, :followed, :followers], User
    can [:update], User, id: user.id
    can :cities, Location
    can [:create, :destroy], Gadget, user_id: user.id
  end
end
