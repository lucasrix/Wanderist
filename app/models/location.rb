class Location < ActiveRecord::Base
  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude
  before_save :assign_geodata

  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :cities, lambda {
    where.not(city: nil)
      .select(:latitude, :longitude, :city)
      .uniq(:city).order(:city)
  }

  private

  def assign_geodata
    AssignGeodataService.call(self)
  end
end
