class StoryPoint < ActiveRecord::Base
  include Likable
  include Pushable
  include Reportable
  include Notificable

  KINDS = %i(audio video photo text).freeze
  CAPTION_MAX_LENGTH = 30
  TEXT_MAX_LENGTH = 1500

  belongs_to :user
  belongs_to :attachment

  has_one :location, as: :locatable

  has_and_belongs_to_many :stories
  has_and_belongs_to_many :tags
  has_many :notifications, as: :notificable

  acts_as_mappable through: :location

  validates :caption, presence: true, length: { maximum: CAPTION_MAX_LENGTH }
  validates :text, presence: true, length: { maximum: TEXT_MAX_LENGTH }
  validates :user, presence: true
  validates :location, presence: true
  validates :kind, presence: true

  validates_associated :location

  validates_presence_of :attachment, unless: :text?

  enum kind: KINDS
end
