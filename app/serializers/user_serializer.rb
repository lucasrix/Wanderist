class UserSerializer < ApplicationSerializer
  include SerializerFollowable

  attributes :id, :provider, :uid, :email, :created_at, :updated_at

  has_one :profile, serializer: MyProfileSerializer
end
