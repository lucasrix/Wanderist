class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :create, :update, :destroy], StoryPoint, user_id: user.id
    can [:read, :create], Attachment, user_id: user.id
    can [:read], Story, user_id: user.id

  end
end
