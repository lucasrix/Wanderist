class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :destroy], StoryPoint, user_id: user.id
    can [:create, :update], StoryPoint, user_id: user.id, attachment_id: nil
    can [:create, :update], StoryPoint, user_id: user.id, attachment: { user_id: user.id }
    can [:create], Attachment, user_id: user.id
  end
end
