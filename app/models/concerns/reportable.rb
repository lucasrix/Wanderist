module Reportable
  extend ActiveSupport::Concern

  delegate :count, to: :reports, prefix: 'reports'

  included do
    has_many :reports, as: :reportable

    scope :readable, lambda { |user|
      includes(:reports).where(blocked: false)
        .where('reports.user_id is null or reports.user_id != ?', user.id)
        .references(:reports)
    }
  end

  def reported?(user)
    reports.exists?(user: user)
  end

  def blocked?
    blocked == true
  end
end
