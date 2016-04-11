class ProfileSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :city, :url, :about, :photo_url, :story_points_count
end
