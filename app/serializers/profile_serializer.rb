class ProfileSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :city, :url, :about, :photo_url,
             :big_thumbnail, :small_thumbnail, :story_points_count, :stories_count, :likes_count, :saves_count
  has_one :location

  def small_thumbnail
    object.photo_url(:small_thumbnail)
  end

  def big_thumbnail
    object.photo_url(:big_thumbnail)
  end
end
