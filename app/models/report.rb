class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  validates :kind, presence: true
end
