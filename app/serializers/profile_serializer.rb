class ProfileSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :city, :url, :about, :photo_url, :posts_count

  def posts_count
    0
  end
end