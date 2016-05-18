class Location < ActiveRecord::Base
  DEFAULT_CITY_PARAMS = { latitude: 38.89, longitude: -77.036, city: 'Washington' }.freeze

  belongs_to :locatable, polymorphic: true

  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  before_save :assign_geodata

  validates :latitude, :longitude, presence: true

  scope :cities, lambda {
    where.not(city: nil)
      .select(:latitude, :longitude, :city, :address)
      .uniq(:city).order(:city)
  }

  private

  def assign_geodata
    AssignGeodataService.call(self)
  end
end
