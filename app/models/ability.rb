class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :create], StoryPoint, user_id: user.id
  end
end
