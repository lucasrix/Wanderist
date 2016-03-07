class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:create, :read, :update, :destroy], StoryPoint, user_id: user.id
    can [:read, :create], Attachment, user_id: user.id
    can [:create, :read, :update, :destroy], Story, user_id: user.id
    can [:update], Profile, user_id: user.id

  end
end
