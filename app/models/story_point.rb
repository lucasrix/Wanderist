class StoryPoint < ActiveRecord::Base
  KINDS = %i(audio video photo text)
  CAPTION_MAX_LENGTH = 30
  TEXT_MAX_LENGTH = 1500

  belongs_to :user
  belongs_to :story
  belongs_to :location
  belongs_to :attachment

  has_and_belongs_to_many :tags

  validates :caption, presence: true, length: { maximum: CAPTION_MAX_LENGTH }
  validates :text, presence: true, length: { maximum: TEXT_MAX_LENGTH }
  validates :user, presence: true
  validates :location, presence: true
  validates :kind, presence: true

  validates_associated :location

  validates_presence_of :attachment, unless: :text?

  enum kind: KINDS


end
