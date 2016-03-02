class ProfileSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :about, :photo_url
end