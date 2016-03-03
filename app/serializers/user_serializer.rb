class UserSerializer < ApplicationSerializer
  attributes :id, :provider, :uid, :email, :created_at, :updated_at

  has_one :profile, serializer: ProfileSerializer
end